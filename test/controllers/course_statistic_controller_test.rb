require 'test_helper'

class CourseStatisticControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get course_statistic_show_url
    assert_response :success
  end

end
