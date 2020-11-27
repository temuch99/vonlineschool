require 'test_helper'

class StaticControllerTest < ActionDispatch::IntegrationTest
  test "should get main" do
    get static_main_url
    assert_response :success
  end

  test "should get contacts" do
    get static_contacts_url
    assert_response :success
  end

end
