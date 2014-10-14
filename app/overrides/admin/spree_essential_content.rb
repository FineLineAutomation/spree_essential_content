# Adds the Content button to the admin tabs
Deface::Override.new(virtual_path:  "spree/layouts/admin",
                     name:          "spree_essential_admin_tabs",
                     insert_bottom: "[data-hook='admin_tabs'], #admin_tabs[data-hook]",
                     partial:       "spree/admin/shared/contents_tab",
                     disabled:      false)

# Adds configuration links to the configurations sidebar
Deface::Override.new(virtual_path:  "spree/admin/shared/_configuration_menu",
                     name:          "add_essential_content_settings_sidebar",
                     insert_bottom: "[data-hook='admin_configurations_sidebar_menu'], #admin_configurations_sidebar_menu[data-hook]",
                     partial:       "spree/admin/shared/blog_config",
                     disabled:      false)
