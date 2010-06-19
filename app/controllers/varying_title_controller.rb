class VaryingTitleController < ApplicationController
  layout "activescaffold"

  before_filter :login_required
  before_filter :set_page_name
  
  active_scaffold :varying_title do |conf|
    conf.create.link.label = "Add a new varying title"
    
    conf.columns.exclude :item
    conf.list.columns = [:id, :title_varying_246a, :item]
    
    columns[:item].label = "Item with varying title" 
    
    conf.actions.exclude :show
  end
  
  private
  def set_page_name
    @pagename = "Varying titles"    
  end
end
