def caesar_cipher string, shift
	return "" if string.nil?
	capital_letters = ("A".."Z").to_a
	lowercase_letters = ("a".."z").to_a
	new_string = ""
	string.each_char do | char |
		if capital_letters.include? char
			new_index = capital_letters.index(char) + shift
			(new_index -= 26) if new_index > 25 
			char = capital_letters[new_index]
		elsif lowercase_letters.include? char
			new_index = lowercase_letters.index(char) + shift
			(new_index -= 26) if new_index > 25 
			char = lowercase_letters[new_index]
		end
	new_string += char
	end
	return new_string
end