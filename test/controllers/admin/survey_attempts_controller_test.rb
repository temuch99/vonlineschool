require 'test_helper'

class Admin::SurveyAttemptsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_survey_attempts_index_url
    assert_response :success
  end

end
