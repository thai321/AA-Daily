class Api::PokemonController < ApplicationController
  def index
    @pokemons = Pokemon.all
    render :index
  end

  def show
    @pokemon = Pokemon.find(params[:id])
    # render :show
  end

  # def create
  #   @pokemon =
  # end
  #
  # private
  # def pokemon_params
  #   # require.params(:pokemon).permit(:name, :image_url, :type, :attack, :defense, :moves [])
  # end
end
