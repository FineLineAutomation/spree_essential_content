module Spree
  module Admin
    class ContentSettingsController < BaseController
      def edit
        @preferences = [
          'disqus_shortname', 'sharethis_publisher_id', 'show_posts_on_homepage',
          'show_products_on_homepage', 'show_taxons_on_homepage'
        ]
        @config = Spree::ContentConfiguration.new
      end

      def update
        config = Spree::ContentConfiguration.new

        params.each do |name, value|
          next unless config.has_preference? name
          config[name] = value
        end

        flash[:success] = Spree.t(:successfully_updated, :resource => Spree.t('essential_content.admin.content_settings'))
        redirect_to edit_admin_content_settings_path
      end

    end
  end
end