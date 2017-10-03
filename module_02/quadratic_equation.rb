puts 'Введите коэффициент a:'
a = gets.chomp.to_i

puts 'Введите коэффициент b:'
b = gets.chomp.to_i

puts 'Введите коэффициент c:'
c = gets.chomp.to_i

discriminant = b**2 - 4 * a * c
if discriminant >= 0
  c = Math.sqrt(discriminant)
  x1 = (-b + c) / (2.0 * a)
  x2 = (-b - c) / (2.0 * a)
  root_info = discriminant.zero? ? "корень = #{x1}" : "x1 = #{x1}, x2 = #{x2}"
else
  root_info = 'корней нет'
end

puts "Дискриминант = #{discriminant}, #{root_info}"
