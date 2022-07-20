require 'test_helper'

class CreatorsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get creators_create_url
    assert_response :success
  end

end
