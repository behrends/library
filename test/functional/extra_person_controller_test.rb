require File.dirname(__FILE__) + '/../test_helper'
require 'extra_person_controller'

# Re-raise errors caught by the controller.
class ExtraPersonController; def rescue_action(e) raise e end; end

class ExtraPersonControllerTest < Test::Unit::TestCase
  def setup
    @controller = ExtraPersonController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
