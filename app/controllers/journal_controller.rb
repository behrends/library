class JournalController < ApplicationController
  layout "activescaffold"

  before_filter :login_required
  before_filter :set_page_name
  
  active_scaffold :journal do |conf|
    conf.create.link.label = "Add a new journal"
    conf.columns.exclude :items
    columns[:items].label = "Items in journal" 
    conf.list.columns = [:id,:name,:items]
    conf.actions.exclude :show
  end
  
  private
  def set_page_name
    @pagename = "Journals"    
  end
end
