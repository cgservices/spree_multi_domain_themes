module SpreeMultiDomainThemes
  class Railtie < ::Rails::Railtie
    initializer "themes_on_rails.action_controller" do |app|
      ActiveSupport.on_load :action_controller do
        def _prefixes_with_store_template
          _prefixes_without_store_template
          store_template = "spree/#{controller_name}/#{current_store.code}"
          @_prefixes.unshift(store_template) unless @_prefixes.include?(store_template)
          @_prefixes
        end
        alias_method_chain :_prefixes, :store_template
      end
    end
  end
end