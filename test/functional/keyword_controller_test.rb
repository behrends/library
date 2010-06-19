require File.dirname(__FILE__) + '/../test_helper'
require 'keyword_controller'

# Re-raise errors caught by the controller.
class KeywordController; def rescue_action(e) raise e end; end

class KeywordControllerTest < Test::Unit::TestCase
  def setup
    @controller = KeywordController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
