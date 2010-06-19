class KibiController < GenericlibraryController
  layout "kibi"

  @@library_location = 2

  # return all approved items in Kibi library sorted by title
  def index
    super
  end

  #used by book lightbox
  def book
    super
  end
  
end
