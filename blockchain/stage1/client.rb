require 'sinatra'
require 'colorize'

BALANCE = {
  'haseeb' => 1_000_00,
}

get "/blance" do
  user = params['user']
  "#{user} has #{BALANCE[user]}"
end


post "/users" do
  name = params['name']
  BALANCE[name] ||=0
  "OK"
end


post "/transfers" do
  from , to = params.values_at('from', 'to').map(&:downcase)
  amount = params['amount'].to_i
  raise unless BALANCES[from] >= amount
  BALANCES[from] -= amount
end
