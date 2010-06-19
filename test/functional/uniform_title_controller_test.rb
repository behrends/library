require File.dirname(__FILE__) + '/../test_helper'
require 'uniform_title_controller'

# Re-raise errors caught by the controller.
class UniformTitleController; def rescue_action(e) raise e end; end

class UniformTitleControllerTest < Test::Unit::TestCase
  def setup
    @controller = UniformTitleController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
