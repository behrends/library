class NoteController < ApplicationController
  layout "activescaffold"

  before_filter :login_required
  
  active_scaffold :note do |conf|
    conf.columns.exclude :item
  end
end
