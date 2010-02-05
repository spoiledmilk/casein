class CaseinScaffoldGenerator < Rails::Generator::NamedBase

  include CaseinHelper

  default_options :force_plural => false, :create_model_and_migration => false

  attr_reader   :controller_name,
                :controller_class_path,
                :controller_file_path,
                :controller_class_nesting,
                :controller_class_nesting_depth,
                :controller_class_name,
                :controller_underscore_name,
                :controller_singular_name,
                :controller_plural_name,
                :should_run_manifest
  alias_method  :controller_file_name,  :controller_underscore_name
  alias_method  :controller_table_name, :controller_plural_name

  def initialize(runtime_args, runtime_options = {})
    super

    @should_run_manifest = true

    if @name == @name.pluralize && !options[:force_plural]
      logger.error "Plural version of the model detected. Use the singular form, or override with --force-plural."
      @should_run_manifest = false
    else
      @controller_name = @name.pluralize

      base_name, @controller_class_path, @controller_file_path, @controller_class_nesting, @controller_class_nesting_depth = extract_modules(@controller_name)
      @controller_class_name_without_nesting, @controller_underscore_name, @controller_plural_name = inflect_names(base_name)
      @controller_singular_name = base_name.singularize
    
      if @controller_class_nesting.empty?
        @controller_class_name = @controller_class_name_without_nesting
      else
        @controller_class_name = "#{@controller_class_nesting}::#{@controller_class_name_without_nesting}"
      end
    end

  end

  def manifest
    record do |m| 
      if @should_run_manifest
        m.class_collisions("Casein#{controller_class_name}Controller", "#{controller_class_name}Helper")
        m.class_collisions(class_name)

        m.directory(File.join('app/views', 'casein_' + controller_file_path))

        for action in scaffold_views
          m.template("view_#{action}.html.erb", File.join('app/views', 'casein_' + controller_file_path, "#{action}.html.erb"))
          m.template("view_#{action}_right_bar.html.erb", File.join('app/views', 'casein_' + controller_file_path, "_#{action}_right_bar.html.erb"))
        end
        
        m.template("_view_table.html.erb", File.join('app/views', 'casein_' + controller_file_path, "_table.html.erb"))
        m.template("_view_form.html.erb", File.join('app/views', 'casein_' + controller_file_path, "_form.html.erb"))
  
        m.template('controller.rb', File.join('app/controllers', controller_class_path, "casein_#{controller_file_name}_controller.rb"))
        m.template('helper.rb', File.join('app/helpers', controller_class_path, "casein_#{controller_file_name}_helper.rb"))
    
        m.template('functional_test.rb', File.join('test/functional', controller_class_path, "casein_#{controller_file_name}_controller_test.rb"))
    
        add_to_routes m
        add_to_navigation m
    
        if options[:force_model_and_migrations]
          m.dependency 'model', [name] + @args, :collision => :skip
        end
      end
    end
  end

  protected

    def banner
      "Usage: #{$0} casein_scaffold ModelName [field:type, field:type]"
    end

    def add_options!(opt)
      opt.separator ''
      opt.separator 'Options:'
      opt.on("--force-plural", "Forces the generation of a plural ModelName") { |v| options[:force_plural] = v }
      opt.on("--create-model-and-migration", "Also creates a model, migration and tests") { |v| options[:force_model_and_migrations] = v }
    end

    def scaffold_views
      %w[ index new show ]
    end
    
    def add_to_navigation m
      file_to_update = 'app/views/casein_layouts/_navigation.html.erb'
      line_to_add = "<li id=\"visitSite\"><%= link_to \"#{plural_name.humanize.capitalize}\", :controller => :casein_#{controller_file_path} %></li>"
      insert_sentinel = '<!-- SCAFFOLD_INSERT -->'
      gsub_add_once m, file_to_update, line_to_add, insert_sentinel
      logger.navigation file_to_update
    end
    
    #replacement for standard Rails generator route_resources. This one only adds once
    def add_to_routes m
      file_to_update = 'config/routes.rb'
      line_to_add = "map.resources :casein_#{controller_file_name}"
      insert_sentinel = 'CaseinAddRoutes::mapper map'
      gsub_add_once m, file_to_update, "  " + line_to_add, insert_sentinel
      logger.route line_to_add
    end
    
    def gsub_add_once m, file, line, sentinel
      unless options[:pretend]    
        m.gsub_file file, /(#{Regexp.escape("\n#{line}")})/mi do |match|
          ''
        end
        m.gsub_file file, /(#{Regexp.escape(sentinel)})/mi do |match|
          "#{match}\n#{line}"
        end
      end
    end

end
