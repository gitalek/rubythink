puts 'Введите год:'
year = gets.chomp.to_i
puts 'Введите номер месяца:'
month = gets.chomp.to_i
puts 'Введите число месяца:'
days_in_month = gets.chomp.to_i

is_leap = (year % 4).zero? && (year % 400).zero? && !(year % 100).zero?

months = [
  31,
  is_leap ? 29 : 28,
  31,
  30,
  31,
  30,
  31,
  31,
  30,
  31,
  30,
  31
]

days_in_previous_months = 0
i = 1
while i < month
  days_in_previous_months += months[i - 1]
  i += 1
end

day_of_year = days_in_previous_months + days_in_month

puts day_of_year
