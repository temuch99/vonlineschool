require 'test_helper'

class Admin::HomeworkAttemptsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_homework_attempts_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_homework_attempts_show_url
    assert_response :success
  end

end
