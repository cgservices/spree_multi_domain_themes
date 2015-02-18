# This decorator overwrites the load_overrides method so it checks if a override should be applied.
# It only loads the overrides if the override is from the current theme.
Deface::Environment::Overrides.class_eval do

  def load_overrides(railtie)
    Deface::Override.current_railtie = railtie.class.to_s
    paths = railtie.respond_to?(:paths) ? railtie.paths["app/overrides"] : nil
    enumerate_and_load(paths, railtie.root)
  end

end