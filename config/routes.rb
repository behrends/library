ActionController::Routing::Routes.draw do |map|
  # map root path "" to application/index which redirects to index.html
  map.root :controller => 'application'
  
  #authentication and session handling
  map.resources :users
  map.resource :session
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login  '/login',  :controller => 'sessions', :action => 'new'

  # Install the default route as the lowest priority.
  map.connect ':controller/:action/:id.:format'
  map.connect ':controller/:action/:id'
end
