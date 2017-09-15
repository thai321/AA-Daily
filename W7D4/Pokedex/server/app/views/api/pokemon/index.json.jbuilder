@pokemons.each do |poke|
  json.set! poke.id do
    json.extract! poke, :id, :name
    json.image_url asset_path(poke.image_url)

    json.item_ids do
      json.array! poke.items.map { |item| item.id }
    end
  end

end

=begin
{
  1: {
    id:
    name:
    image_url:
  },
  2: {
    id:
    name:
    image_url:
    }
  ...
}

=end
