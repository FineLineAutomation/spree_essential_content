module SpreeEssentialContent
  class Engine < Rails::Engine
    require 'spree/core'
    isolate_namespace Spree
    engine_name 'spree_essential_content'

    config.autoload_paths += %W(#{config.root}/lib)

    # use rspec for tests
    config.generators do |g|
       g.test_framework :rspec,
         fixtures: true,
         view_specs: false,
         helper_specs: false,
         routing_specs: false,
         controller_specs: true,
         request_specs: false
       g.fixture_replacement :factory_girl, dir: "spec/factories"
    end

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), '../../app/**/*_decorator*.rb')) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end

      Dir.glob File.expand_path("../../../app/overrides/**/*.rb", __FILE__) do |c|
        Rails.application.config.cache_classes ? require(c) : load(c)
      end
    end

    config.to_prepare &method(:activate).to_proc
  end
end
