class EcController < GenericlibraryController
  layout "ec"

  @@library_location = 3
  
  # return all approved items in EC library sorted by title
  def index
    super
  end

  #used by book lightbox
  def book
    super
  end
  
end
