class SeriesController < ApplicationController
  layout "activescaffold"

  before_filter :login_required
  before_filter :set_page_name
  
  active_scaffold :series  do |conf|
    conf.create.link.label = "Add a new series"
    conf.columns.exclude :items, :items_series
    columns[:items].label = "Items in series" 
    conf.list.columns = [:id,:name,:number, :items]
    
    conf.actions.exclude :show
  end
  
  private
  def set_page_name
    @pagename = "Series"    
  end
end
