ActionController::Routing::Routes.draw do |map|

  map.resource :password

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

  # '/logout' and '/login' should take precedence for RSpec to run without errors
  map.resource :session

  # "root" route needed to run RSpec stories for the the restful_authentication plugin
  map.root :controller => 'welcome',  :action => 'index'

  # Default routes removed for safety
  # map.connect ':controller/:action/:id'
  # map.connect ':controller/:action/:id.:format'
  
end
