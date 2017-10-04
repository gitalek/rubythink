puts 'Введите год:'
year = gets.chomp.to_i
puts 'Введите номер месяца:'
month = gets.chomp.to_i
puts 'Введите число месяца:'
days_in_month = gets.chomp.to_i

is_leap = (year % 4).zero? && (year % 400).zero? && !(year % 100).zero?

months = {
  1 => 31,
  2 =>  is_leap ? 29 : 28,
  3 => 31,
  4 => 30,
  5 => 31,
  6 => 30,
  7 => 31,
  8 => 31,
  9 => 30,
  10 => 31,
  11 => 30,
  12 => 31
}

days_in_previous_months = 0
i = 1
while i < month
  days_in_previous_months += months[i]
  i += 1
end

day_of_year = days_in_previous_months + days_in_month

puts day_of_year
