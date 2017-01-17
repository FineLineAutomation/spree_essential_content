# Adds posts display to products
Deface::Override.new(virtual_path:  "spree/products/show",
                     name:          "add_posts_to_products_display",
                     insert_bottom: "[data-hook='product_left_part']",
                     partial:       "spree/products/posts")