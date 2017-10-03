puts 'Введите длину для каждой из сторон треугольника'

puts 'Первая сторона треугольника:'
a = gets.chomp.to_i

puts 'Вторая сторона треугольника:'
b = gets.chomp.to_i

puts 'Третья сторона треугольника:'
c = gets.chomp.to_i

if a > b && a > c
  first_cathetus = b
  second_cathetus = c
  hypotenuse = a
elsif b > a && b > c
  first_cathetus = a
  second_cathetus = c
  hypotenuse = b
elsif c > a && c > b
  first_cathetus = a
  second_cathetus = b
  hypotenuse = c
end

is_equilateral = (a == b) && (a == c) && (b == c)
if is_equilateral
  puts 'Треугольник - равносторонний'
else
  is_rectangular = hypotenuse**2 == first_cathetus**2 + second_cathetus**2
  is_isosceles = first_cathetus == second_cathetus
  if is_rectangular
    puts 'Треугольник - прямоугольный'
  elsif is_isosceles
    puts 'Треугольник - равнобедренный'
  end
end
