vowels = %w[a e i o u y]
alphabet = ('a'..'z').to_a

result = {}

alphabet.each_index do |index|
  letter = alphabet[index]
  result[letter] = index + 1 if vowels.include?(letter)
end

puts result.inspect
