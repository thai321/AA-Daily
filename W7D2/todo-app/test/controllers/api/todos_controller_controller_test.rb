require 'test_helper'

class Api::TodosControllerControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get api_todos_controller_show_url
    assert_response :success
  end

  test "should get index" do
    get api_todos_controller_index_url
    assert_response :success
  end

  test "should get create" do
    get api_todos_controller_create_url
    assert_response :success
  end

  test "should get update" do
    get api_todos_controller_update_url
    assert_response :success
  end

  test "should get destroy" do
    get api_todos_controller_destroy_url
    assert_response :success
  end

end
