Templater::Application.routes.draw do
  #match '*/public/*', to: '/', via: :get

  match 'login', to: 'sessions#new', via: [:get, :post]
  #match 'login/failed', to: redirect('/'), via: [:get, :post]
  match 'logout', to: 'sessions#destroy', as: 'logout', via: [:get, :post]
  resource :sessions, only: [:new, :create, :destroy]
  
  mount Mercury::Engine => '/'
  resources :prawn, only: [:index]

  #match "*documents/*page", to: "documents#respond", via: :get
  match "show", to: "documents#show", via: :get
  #match "generate", to: "documents#generate", via: :get
  #match "*events//edit", to: "events#new", via: :all
  #match "*mercury_update", to: "documents#mercury_update", via: :put
  
  namespace :mercury do
    resources :images
  end
  
  resources :users do
    resources :campaigns do
      member do
        #get :generate, to: 'documents'
        match '/generate', to: 'documents#generate', via: :get
        
      end
      #resource :documents, only: :show
      #member { put :mercury_update }
      resources :campaign_contacts
      resources :events, :training_sheets, :enlistments, :gift_profiles do
        resources :documents, only: :show
      end
    end
  end
  
  resources :campaigns, :only => [:mercury_update] do
    member { put :mercury_update }
  end
  
  resources :sql_templates
  #resources :campaigns
  match 'campaigns', to: 'users#admin_all', via: :all
  match '/zip', to: 'documents#zip_selected_resp_docs', via: :post
  #scope 'admin' do
    #resources :users, :campaigns, :sql_templates
    #end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'users#index'

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
