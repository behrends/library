class ExtraPersonController < ApplicationController
  layout "activescaffold"

  before_filter :login_required
    
  active_scaffold :extra_person do |conf|
    conf.columns.exclude :items
  end

end
