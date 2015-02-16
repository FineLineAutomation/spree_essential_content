class Spree::PossibleBlog
  def self.matches?(request)
    binding.remote_pry
    return false if request.path =~ /(^\/+(admin|account|cart|checkout|content|login|logout|pg\/|orders|products|s\/|session|signup|shipments|states|t\/|tax_categories|user|paypal)+)/
    Spree::Blog.where(permalink: request.path.to_s.downcase.gsub(/(^\/+)|(\/+$)/, "")).any?
  end
end

class Spree::PossiblePage
  def self.matches?(request)
    return false if request.path =~ /(^\/+(admin|account|cart|checkout|content|login|logout|pg\/|orders|products|s\/|session|signup|shipments|states|t\/|tax_categories|user|paypal)+)/
    !Spree::Page.active.get_page_by_path(request.path).nil?
  end
end

Spree::Core::Engine.append_routes do
  namespace :admin do
    resources :uploads

    resources :pages, :constraints => { :id => /.*/ } do
      collection do
        post :update_positions
      end

      resources :contents do
        collection do
          post :update_positions
        end
      end

      resources :images, :controller => "page_images" do
        collection do
          post :update_positions
        end
      end
    end

    resources :blogs, :constraints => { :id => /[a-z0-9\-\_\/]{3,}/ }

    resources :posts, except: [:show] do
      resources :images, except: [:show], controller: "post_images" do
        collection do
          post :update_positions
        end
      end
      resources :products, only: [:index, :update, :delete], controller: "post_products"
      resources :categories, except: [:show], :controller => "post_categories"
    end

    resource :content_settings, only: [:edit, :update]
  end

  constraints(Spree::PossibleBlog) do
    constraints(
      :year  => /\d{4}/,
      :month => /\d{1,2}/,
      :day   => /\d{1,2}/
    ) do
      get ":blog_id/:year(/:month(/:day))" => "posts#index", :as => :post_date
      get ":blog_id/:year/:month/:day/:id" => "posts#show",  :as => :full_post
    end

    get ":blog_id/category/:id"   => "post_categories#show", :as => :post_category, :constraints => { :id => /.*/ }
    get ":blog_id/search/:query"  => "posts#search",         :as => :search_posts, :query => /.*/
    get ":blog_id/archive"        => "posts#archive",        :as => :archive_posts
    get ":blog_id"                => "posts#index",          :as => :blog_posts
  end

  constraints(Spree::PossiblePage) do
    get '/(*path)', to: 'pages#show', as: 'page'
  end
end
