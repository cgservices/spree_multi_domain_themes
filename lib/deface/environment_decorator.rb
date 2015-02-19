# This decorator overwrites the load_overrides method so it checks if a override should be applied.
# It only loads the overrides if the override is from the current theme.
Deface::Environment::Overrides.class_eval do

  def load_overrides(railtie)
    unless SpreeMultiDomainThemes.themes_to_remove.collect { |theme| railtie.root.to_s.include?(theme) }.any?
      Deface::Override.current_railtie = railtie.class.to_s
      enumerate_and_load(["app/overrides/#{SpreeMultiDomainThemes.current_theme}"], railtie.root)
    end
  end

end