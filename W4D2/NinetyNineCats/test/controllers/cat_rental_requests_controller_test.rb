require 'test_helper'

class CatRentalRequestsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get cat_rental_requests_new_url
    assert_response :success
  end

  test "should get create" do
    get cat_rental_requests_create_url
    assert_response :success
  end

end
