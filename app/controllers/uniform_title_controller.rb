class UniformTitleController < ApplicationController
  layout "activescaffold"

  before_filter :login_required
  before_filter :set_page_name
  
  active_scaffold :uniform_title do |conf|
    conf.create.link.label = "Add a new uniform title"
    conf.columns.exclude :items
    conf.list.columns = [:id, :uniformtitle_240a, :uniformtitle_subheading_240k,
      :uniformtitle_misc_240g, :uniformtitle_number_part_240n, 
      :uniformtitle_part_name_240p, :items]
    
    columns[:items].label = "Items with uniform title" 
    
    conf.actions.exclude :show
  end
  
  private
  def set_page_name
    @pagename = "Uniform titles"    
  end
end
