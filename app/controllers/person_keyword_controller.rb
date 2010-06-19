class PersonKeywordController < ApplicationController
  layout "activescaffold"

  before_filter :login_required
  before_filter :set_page_name
  
  active_scaffold :person_keyword do |conf|
    conf.create.link.label = "Add a new person keyword"
    conf.label = 'Person keywords'
    conf.columns.exclude :items, :items_person_keywords
    conf.actions.exclude :show
  end
  
  private
  def set_page_name
    @pagename = "Person keywords"    
  end
end
