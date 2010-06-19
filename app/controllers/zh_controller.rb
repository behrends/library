class ZhController < GenericlibraryController
  layout "zh"

  @@library_location = 6

  # return all approved items in Zurich library sorted by title
  def index    
    super
  end

  #used by book lightbox
  def book
    super
  end
  
end
