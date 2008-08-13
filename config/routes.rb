ActionController::Routing::Routes.draw do |map|

  map.resource :password
  map.resource :session
  map.logout          '/logout',              :controller => 'sessions', :action => 'destroy'
  map.login           '/login',               :controller => 'sessions', :action => 'new'
  map.register        '/register',            :controller => 'users', :action => 'create'
  map.signup          '/signup',              :controller => 'users', :action => 'new'
  map.activate        '/activate/:activation_code', :controller => 'users', :action => 'activate', :activation_code => nil
  map.forgot_password '/forgot_password',      :controller => 'passwords', :action => 'new'
  map.reset_password  '/reset_password/:id',  :controller => 'passwords', :action => 'edit'
  
  map.resources :users, :member => { :suspend   => :put,
                                     :unsuspend => :put,
                                     :purge     => :delete } do |user|
    user.resources :roles
  end

  # needed to run RSpec stories as installed by the the restful_authentication plugin
  map.root :controller => 'sessions', :action => 'new'

  # Default routes removed for safety
  # map.connect ':controller/:action/:id'
  # map.connect ':controller/:action/:id.:format'
  
end
