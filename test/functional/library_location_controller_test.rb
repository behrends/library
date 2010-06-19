require File.dirname(__FILE__) + '/../test_helper'
require 'library_location_controller'

# Re-raise errors caught by the controller.
class LibraryLocationController; def rescue_action(e) raise e end; end

class LibraryLocationControllerTest < Test::Unit::TestCase
  def setup
    @controller = LibraryLocationController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
