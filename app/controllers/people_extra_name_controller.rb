class PeopleExtraNameController < ApplicationController
  layout "activescaffold"

  before_filter :login_required
  before_filter :set_page_name
  
  active_scaffold :people_extra_name do |conf|
    conf.create.link.label = "Add a new author name"
    conf.label = 'Author names'
    conf.columns.exclude :person
    conf.columns = [:person, :alternative_name_400a, :alternative_name_origin_400c]
    columns[:person].label = 'Main name (author/person)'
    columns[:person].set_link('nested', :parameters => {:associations => :person})
    
    conf.actions.exclude :show
  end
  
  private
  def set_page_name
    @pagename = "Author names"    
  end
end
