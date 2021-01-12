require 'test_helper'

class Admin::BankControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_bank_index_url
    assert_response :success
  end

end
