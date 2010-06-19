require File.dirname(__FILE__) + '/../test_helper'
require 'publisher_controller'

# Re-raise errors caught by the controller.
class PublisherController; def rescue_action(e) raise e end; end

class PublisherControllerTest < Test::Unit::TestCase
  def setup
    @controller = PublisherController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
