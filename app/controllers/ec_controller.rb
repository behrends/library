class EcController < GenericlibraryController
  layout "ec"

  
  # return all approved items in EC library sorted by title
  def index
    @library_location = 3
    super
  end

  #used by book lightbox
  def book
    @library_location = 3
    super
  end
  
end
