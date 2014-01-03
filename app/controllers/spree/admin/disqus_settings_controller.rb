module Spree
  module Admin
    class DisqusSettingsController < BaseController

      def show
        @preferences = ['disqus_shortname', 'sharethis_publisher_id']
        @config = Spree::BlogConfiguration.new
      end

      def edit
        @preferences = ['disqus_shortname', 'sharethis_publisher_id']
        @config = Spree::BlogConfiguration.new
      end

      def update
        config = Spree::BlogConfiguration.new

        params.each do |name, value|
          next unless config.has_preference? name
          config[name] = value
        end

        redirect_to admin_disqus_settings_path
      end

    end
  end
end