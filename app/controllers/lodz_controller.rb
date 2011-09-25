class LodzController < GenericlibraryController
  layout "lodz"

  @@library_location = 7

  # return all approved items in Lodz library sorted by title
  def index
    super
  end

  #used by book lightbox
  def book
    super
  end

end
