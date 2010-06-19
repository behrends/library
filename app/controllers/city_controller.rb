class CityController < ApplicationController
  layout "activescaffold"

  before_filter :login_required
  before_filter :set_page_name
  
  active_scaffold :city  do |conf|
    conf.create.link.label = "Add a new city"
    conf.columns.exclude :items
    conf.list.columns = [:id,:name,:country]
    
    conf.actions.exclude :show
  end
  
  private
  
  def set_page_name
    @pagename = "Cities"    
  end
    
end
