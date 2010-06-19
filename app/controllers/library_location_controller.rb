class LibraryLocationController < ApplicationController
  layout "activescaffold"

  before_filter :login_required
  
  active_scaffold :library_location do |conf|
    conf.columns.exclude :items, :items_library_locations
    conf.list.columns = [:id, :name]    
    
    conf.actions.exclude :show, :create, :delete
  end
end
