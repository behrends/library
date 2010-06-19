require File.dirname(__FILE__) + '/../test_helper'
require 'language_code_controller'

# Re-raise errors caught by the controller.
class LanguageCodeController; def rescue_action(e) raise e end; end

class LanguageCodeControllerTest < Test::Unit::TestCase
  def setup
    @controller = LanguageCodeController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
