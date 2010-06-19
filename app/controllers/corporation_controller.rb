class CorporationController < ApplicationController
  layout "activescaffold"

  before_filter :login_required
  before_filter :set_page_name
  
  active_scaffold :corporation do |conf|
    conf.create.link.label = "Add a new corporation"
    conf.columns.exclude :items, :items_corporations
    columns[:items].label = "Items associated to this corporation"
    conf.list.columns = [:id,:name, :items]
    conf.actions.exclude :show
  end
  
  private
  
  def set_page_name
    @pagename = "Corporations"    
  end
end
