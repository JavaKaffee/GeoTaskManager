GeoTaskManager::Application.routes.draw do

  #Beim Aufruf der Startseite wird die User-Übersicht (Login) gezeigt
  root :to => 'users#index'
  
  #Da alle Daten von den Usern abhängig sind, bilden diese das erste Segment
  #In dieser Version werden User lediglich registriert und somit keine Routen
  #zum Zeigen/Editieren zur Verfügung gestellt
  resources :users, :except => [:show, :edit, :update] do
    collection do #Eine Route zur Weiterleitung der User zu ihren Kontexten
      post 'load'
    end
    #Zunächst werden weitere Routen für die Task-Darstellung angelegt, die
    #unabhängig von den Kontexten angezeigt werden
    resources :tasks, :except => [:index, :show, :new, :edit, :create, :update, :destroy] do
      collection do #Hier werden die Tasks nach verschiedenen Kriterien dargestellt
        get 'today'
        get 'week'
        get 'overdue'
        get 'important'
      end
    end
    #Die Kontexte sind die erste geschachtelte Ressource der User
    resources :contexts do
      collection do #Angefügt wird eine Route für den lokalen Kontext
        post 'here'
      end
      #Die Modelbeziehung Kontext -> Tasks wird auch als Route abgebildet
      resources :tasks, :except => [:index, :show]
    end
  end
  

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
