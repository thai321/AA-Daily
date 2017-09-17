require 'test_helper'

class Api::BenchesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_benches_index_url
    assert_response :success
  end

  test "should get create" do
    get api_benches_create_url
    assert_response :success
  end

end
