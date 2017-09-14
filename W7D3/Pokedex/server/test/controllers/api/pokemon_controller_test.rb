require 'test_helper'

class Api::PokemonControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_pokemon_index_url
    assert_response :success
  end

  test "should get show" do
    get api_pokemon_show_url
    assert_response :success
  end

end
