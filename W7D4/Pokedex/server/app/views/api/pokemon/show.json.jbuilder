
json.pokemon do
  json.extract! @pokemon, :id, :name, :attack, :defense, :image_url, :moves, :poke_type

  # json.item_ids do
  #   json.array! @pokemon.items.map { |item| item.id }
  # end
end




json.items do
  json.array! @pokemon.items do |item|
    json.extract! item, :id, :name, :pokemon_id, :price, :happiness, :image_url
  end
end
