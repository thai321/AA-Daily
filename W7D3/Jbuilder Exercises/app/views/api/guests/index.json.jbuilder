json.array! @guests do |guest|
  if guest.age >=40 && guest.age <= 50
    json.partial! 'api/guests/guest', guest: guest
  end
end


# json.array! @guests, partial: 'api/guests/guest', as: :guest
