class PersonController < ApplicationController
  layout "activescaffold"

  before_filter :login_required
  before_filter :set_page_name
    
  active_scaffold :person do |conf|
    conf.create.link.label = "Add a new author"
    conf.label = 'Authors'
    conf.columns.exclude :handwrite_authors, :handwritten_items
    columns[:people_extra_names].set_link('nested', :parameters => {:associations => :people_extra_names})
    columns[:co_authored_items].set_link('nested', :parameters => {:associations => :extra_people})
        
    conf.columns[:people_extra_names].search_sql = "people_extra_names.alternative_name_400a"
    conf.search.columns << :people_extra_names
    
    columns[:co_authored_items].label = "Co-authored items"
    
    conf.list.columns = [:id, :name, :title_100c, :date_100d, :fullname_100q, :display_name,
      :people_extra_names, :items, :co_authored_items]
    conf.update.columns = [:name, :title_100c, :date_100d, :fullname_100q, :display_name]
    conf.create.columns = [:name, :title_100c, :date_100d, :fullname_100q, :display_name]    
  end
  
  private
  def set_page_name
    @pagename = "Authors"    
  end
end
