ServiziStudenti::Application.routes.draw do
  resources :students
  resources :exams

  get 'students/:id/key' => 'students#key', :as => :key 
  get 'students/:id/study_plan' => 'students#get_study_plan', :as => :study_plan 
  get 'students/:id/passed_exams' => 'students#get_passed_exams', :as => :passed_exams 
  get 'students/:id/isee' => 'students#get_isee', :as => :isee 
  get 'students/:id/payments/:status' => 'students#get_payments', :as => :payments 
  get 'sessions' => 'exams#get_sessions', :as => :exam_sessions

  post 'sessions/booking' => 'exams#book', :as => :session_booking
  get 'sessions/bookings' => 'exams#get_bookings', :as => :session_bookings
  delete 'sessions/bookings' => 'exams#delete_booking', :as => :delete_session_booking
  

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
