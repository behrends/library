require File.dirname(__FILE__) + '/../test_helper'
require 'people_extra_name_controller'

# Re-raise errors caught by the controller.
class PeopleExtraNameController; def rescue_action(e) raise e end; end

class PeopleExtraNameControllerTest < Test::Unit::TestCase
  def setup
    @controller = PeopleExtraNameController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
