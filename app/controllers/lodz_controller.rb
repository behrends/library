class LodzController < GenericlibraryController
  layout "lodz"

  # return all approved items in Lodz library sorted by title
  def index
    @library_location = 7
    super
  end

  #used by book lightbox
  def book
    @library_location = 7
    super
  end

end
