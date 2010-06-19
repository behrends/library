class LanguageCodeController < ApplicationController
  layout "activescaffold"

  before_filter :login_required
  before_filter :set_page_name
  
  active_scaffold :language_code  do |conf|
    conf.label = 'Languages'
    conf.list.columns.exclude :items, :language041as, :language041hs
    
    conf.actions.exclude :show, :create, :delete, :update
  end
  
  private
  def set_page_name
    @pagename = "Languages"    
  end
end
