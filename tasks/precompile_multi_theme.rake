require 'deface'

namespace :deface do
  include Deface::TemplateHelper

  desc "Precompiles overrides into template files for multiple themes"
  task :precompile_multi_theme => [:environment, :clean] do |t, args|

    Rails.application.config.deface = Deface::Environment.new
    Rails.application.config.deface.overrides.early_check

    default_view_paths = ActionController::Base.view_paths

    SpreeMultiDomainThemes.themes.each do |theme|

      puts "Percompiling views for theme '#{theme}'"

      base_path = Rails.root.join("app/compiled_views/" + theme)

      SpreeMultiDomainThemes.current_theme = theme

      ActionController::Base.view_paths = SpreeMultiDomainThemes.get_view_paths(default_view_paths)
      Deface::TemplateHelper.view_paths = ActionController::Base.view_paths

      Rails.application.config.deface.overrides.load_all Rails.application

      Rails.application.config.deface.overrides.all.each do |virtual_path,overrides|
        template_path = base_path.join( "#{virtual_path}.html.erb")

        FileUtils.mkdir_p template_path.dirname
        begin
          source = load_template_source(virtual_path.to_s, false, true)
          if source.blank?
            raise "Compiled source was blank for '#{virtual_path}'"
          end
          File.open(template_path, 'w') {|f| f.write source }
        rescue Exception => e
          puts "Unable to precompile '#{virtual_path}' due to: "
          puts e.message
        end
      end
    end
  end

  desc "Removes all precompiled theme override templates"
  task :clean_multi_theme do
    SpreeMultiDomainThemes.themes.each do |theme|
      FileUtils.rm_rf Rails.root.join("app/compiled_views/" + theme)
    end
  end

end
