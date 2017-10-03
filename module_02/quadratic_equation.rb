puts 'Введите коэффициент a:'
a = gets.chomp.to_f

puts 'Введите коэффициент b:'
b = gets.chomp.to_f

puts 'Введите коэффициент c:'
c = gets.chomp.to_f

discriminant = b**2 - 4 * a * c
root_info =
  if discriminant.zero?
    "корень = #{-b / (2.0 * a)}"
  elsif discriminant > 0
    c = Math.sqrt(discriminant)
    x1 = (-b + c) / (2.0 * a)
    x2 = (-b - c) / (2.0 * a)
    "x1 = #{x1}, x2 = #{x2}"
  else
    'корней нет'
  end

puts "Дискриминант = #{discriminant}, #{root_info}"
