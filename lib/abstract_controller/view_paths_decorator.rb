# this decorator sets the new view path array in the lookup_context so the application has the correct view paths
# everywhere it looks for a specific view
AbstractController::ViewPaths.module_eval do

  def set_view_paths
    lookup_context.view_paths = SpreeMultiDomainThemes.get_view_paths(lookup_context.view_paths)
  end

end