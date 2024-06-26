Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  namespace :account_block do
    resources :accounts, only: [:create, :show, :update, :destroy]
    post 'create_account', to: 'accounts#create_account'
    put 'update_account', to: 'accounts#update_account' 
    get 'show_account/:id', to: 'accounts#show_account'    
    delete 'destroy_account/:id', to: 'accounts#destroy_account'
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
    put 'service_request', to: 'services#service_request'
    get 'listing_service', to: 'services#listing_service'
  end

  namespace :bx_block_booking do
    get 'index_bookings', to: 'bookings#index_bookings'
    post 'create_booking', to: 'bookings#create_booking'
    put 'update_booking', to: 'bookings#update_booking'  
    get 'show_booking', to: 'bookings#show_booking'       
    delete 'delete_booking', to: 'bookings#delete_booking' 
    put 'complete_service', to: 'bookings#complete_service'
    # get 'bookings/:id/invoice', to: 'bookings#invoice', as: 'booking_invoice'
  end

  namespace :bx_block_location do
    post 'create_location', to: 'locations#create_location'
    put 'update_location', to: 'locations#update_location'
    delete 'delete_location', to: 'locations#delete_location'
    get 'show_location', to: 'locations#show_location'
    get 'index_locations',to: 'locations#index_locations'
  end

  namespace :bx_block_availability do
   post 'create_availability', to: 'availabilitys#create_availability'
   put 'update_availability', to: 'availabilitys#update_availability'
   delete 'delete_availability', to: 'availabilitys#delete_availability'
   get 'show_availability', to: 'availabilitys#show_availability'
  end
end
