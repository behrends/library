# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  
  include AuthenticatedSystem 
  
  #time format to be used in the whole app
  ActiveSupport::CoreExtensions::Time::Conversions::DATE_FORMATS[:default] = '%d %B %Y %H:%M'

  # Pick a unique cookie name to distinguish our session data from others'
  session :session_key => '_Library_session_id'
  
  ActiveScaffold.set_defaults do |conf|    
    conf.list.per_page = 25
    conf.theme = :blue
  end 
  
  # we use this method only in routes.rb where "" is mapped to this method
  def index
     redirect_to root_path
  end   
end
