class PublisherController < ApplicationController
  layout "activescaffold"

  before_filter :login_required
  before_filter :set_page_name
  
  active_scaffold :publisher do |conf|
    conf.create.link.label = "Add a new publisher"
    conf.columns.exclude :items
    conf.list.columns = [:id,:name]
    conf.actions.exclude :show
    conf.search.columns << :id
  end
  
  private
  def set_page_name
    @pagename = "Publishers"    
  end
end
