class KeywordController < ApplicationController
  layout "activescaffold"

  before_filter :login_required
  before_filter :set_page_name
  
  active_scaffold :keyword do |conf|
    conf.create.link.label = "Add a new keyword"
    conf.columns.exclude :items, :items_keywords
    conf.list.columns = [:id,:keyword]
    conf.actions.exclude :show
  end
  
  private
  def set_page_name
    @pagename = "Keywords"    
  end
end
