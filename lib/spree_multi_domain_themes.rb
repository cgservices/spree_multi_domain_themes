require 'spree_core'
require 'spree_multi_domain_themes/engine'

module SpreeMultiDomainThemes

  mattr_accessor :themes
  mattr_accessor :current_theme

  # this method builds a new view_path array give a current array of view_paths.
  def self.get_view_paths(current_view_paths)
    new_view_paths = ActionView::PathSet.new
    current_view_paths.each do |view_path|
      new_view_paths << view_path
    end
    new_view_paths
  end

end