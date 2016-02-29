Rails.application.routes.draw do

  resources :properties do
    collection do 
      get 'search'
      get 'page/:page' => 'properties#paginate', as: :page
    end  
    member do
      post 'add_customer'
      get 'remove_customer/:customer_id' => 'properties#remove_customer', as: :remove_customer
    end
  end

  resources :agents do
    collection do 
      get 'search'
      get 'page/:page' => 'agents#paginate', as: :page
    end  
  end  

  resources :customers do
    collection do 
      get 'search'
      get 'page/:page' => 'customers#paginate', as: :page
    end  
  end  

  resources :states do
    collection do 
      get 'search'
      get 'page/:page' => 'states#paginate', as: :page
    end  
  end  


  resources :users do
    collection do 
      get 'search'
      get 'page/:page' => 'users#paginate', as: :page
    end  
  end  

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'sessions#index'

  get 'login' => 'sessions#index'
  get 'sessions/forgot_password'
  post 'sessions/create'
  delete 'sessions/destroy'
  get 'dashboard' => 'dashboard#index'

  get 'my_account', to: 'my_account#show'
  put 'my_account', to: 'my_account#update'
  patch 'my_account', to: 'my_account#update'

  get 'reports' => 'reports#index'

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
