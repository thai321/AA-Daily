require 'Set'

def well_formed?(str)
  lookup =  {'(' => ')', '[' => ']', '{' => '}' }
  stack = []

  str.split('').each do |bracket|
    puts "brack", bracket
    puts "stack = ", stack
    if(lookup[bracket])
      stack.push(bracket)
      # p stack
    elsif stack.empty? || lookup[stack.pop] != bracket
      # p stack
      return false
    end
  end

  return true
end

puts well_formed?('([])')
