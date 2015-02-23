require 'spree_core'
require 'spree_multi_domain_themes/engine'

module SpreeMultiDomainThemes

  mattr_accessor :current_theme
  mattr_accessor :themes

  def self.themes
    ::Spree::Store.all.map{|store| store.code}
  end

  def self.themes_to_remove
    themes - [current_theme]
  end

  # this method builds a new view_path array give a current array of view_paths.
  def self.get_view_paths(current_view_paths)
    new_view_paths = ActionView::PathSet.new
    current_view_paths.each do |view_path|
      new_view_paths << view_path unless SpreeMultiDomainThemes.themes_to_remove.collect{ |theme| view_path.to_s.include?(theme) }.any?
    end
    new_view_paths
  end

end