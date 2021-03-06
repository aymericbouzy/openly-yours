OpenlyYours::Application.routes.draw do

  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users

  resources :letters, only: [:index, :show] do
    member do
      put 'follow'
      put 'unfollow'
      get 'followers'
    end
  end

  resources :users, only: [:index, :show] do
    resources :letters, only: [:show] do
      collection do
        get 'followed'
        root to: "letters#user_index"
      end
    end
  end

  resource :me, only: [:show, :edit, :update] do
    resources :letters, except: [:index] do
      collection do
        get 'followed'
        get 'rough_drafts'
        root to: "letters#me_index"
      end
      put 'publish', on: :member
    end
  end

  resources :recipients do
    get 'letters'
  end

  root to: "letters#index"

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
