basket = {}
loop do
  puts 'Наименование товара:'
  brand = gets.chomp
  break if brand == 'стоп'
  puts 'Цена единицы товара:'
  price = gets.chomp.to_f
  puts 'Количество:'
  amount = gets.chomp.to_f

  puts

  basket[brand] = { price: price, amount: amount }
end

puts

total = 0
basket.each_pair do |brand, data|
  price  = data[:price]
  amount = data[:amount]
  sum    = price * amount
  total += sum

  puts "Наименование: #{brand}, цена: #{price}, количество: #{amount}. Сумма по товару: #{sum}"
  puts
end

puts "Итоговая сумма заказа: #{total}"
puts
