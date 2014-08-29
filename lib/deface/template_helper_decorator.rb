# This decorator is only used to make this helper use the view_paths we set.
# Default this uses ActionController::Base.view_paths which is not what rails
# currently uses, so if we don't change this the rails view_paths and deface view_paths would
# be different and deface overrides from other themes would be applied
Deface::TemplateHelper.module_eval do

  mattr_accessor :view_paths

  # used to find source for a partial or template using virutal_path
  def load_template_source(virtual_path, partial, apply_overrides=true)
    parts = virtual_path.split("/")
    prefix = []
    if parts.size == 2
      prefix << ""
      name = virtual_path
    else
      prefix << parts.shift
      name = parts.join("/")
    end

    #this needs to be reviewed for production mode, overrides not present
    Rails.application.config.deface.enabled = apply_overrides
    # this used to be ||= but this doesn't work while pre compiling multiple themes
    @lookup_context = ActionView::LookupContext.new(self.view_paths, {:formats => [:html]})
    view = @lookup_context.disable_cache do
      @lookup_context.find(name, prefix, partial)
    end

    if view.handler.to_s == "Haml::Plugin"
      Deface::HamlConverter.new(view.source).result
    else
      view.source
    end
  end

end