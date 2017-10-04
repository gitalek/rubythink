a = 0
b = 1
c = 1

result = [a, b]

while c <= 100
  result << c

  a = b
  b = c
  c = a + b
end

puts result
