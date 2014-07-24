class KibiController < GenericlibraryController
  layout "kibi"

  # return all approved items in Kibi library sorted by title
  def index
    @library_location = 2
    super
  end

  #used by book lightbox
  def book
    @library_location = 2
    super
  end

end
