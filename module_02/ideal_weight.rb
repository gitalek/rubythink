puts "Как вас зовут?"
name = gets.chomp

puts "Какой у вас рост?"
height = gets.chomp.to_i

ideal_weight = height - 110
if ideal_weight >= 0
  puts "#{name}, ваш идеальный вес - #{ideal_weight} кг."
else
  puts "Ваш вес уже оптимальный!"
end
