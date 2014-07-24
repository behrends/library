class ZhController < GenericlibraryController
  layout "zh"

  # return all approved items in Zurich library sorted by title
  def index
    @library_location = 6
    super
  end

  #used by book lightbox
  def book
    @library_location = 6
    super
  end

end
