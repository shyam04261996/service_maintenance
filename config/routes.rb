Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  namespace :account_block do
    resources :accounts, only: [:create, :show, :update, :destroy]
    post 'create_account', to: 'accounts#create_account'
    put 'update_account/:id', to: 'accounts#update_account' # Include ':id' placeholder for update
    get 'show_account/:id', to: 'accounts#show_account'     # Include ':id' placeholder for show
    delete 'destroy_account/:id', to: 'accounts#destroy_account' # Include ':id' placeholder for destroy
  end
  

  namespace :bx_block_login do 
    post 'login', to: 'logins#login'
    delete '/logout', to: 'logins#destroy'
    # post 'generate_otp', to: 'logins#generate_otp'
  end

  namespace :bx_block_service do
    post 'create_service', to: 'services#create_service'
    put 'update_service', to: 'services#update_service'
    get 'show_service', to: 'services#show_service'
    delete 'delete_service', to: 'services#delete_service'
  end

  namespace :bx_block_booking do
    get 'index_bookings', to: 'bookings#index_bookings'
    post 'create_booking', to: 'bookings#create_booking'
    put 'update_booking', to: 'bookings#update_booking'  # Corrected route
    get 'show_booking', to: 'bookings#show_booking'       # Corrected route
    delete 'delete_booking', to: 'bookings#delete_booking' # Corrected route
  end
end
