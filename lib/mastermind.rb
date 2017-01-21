class MastermindGame

	attr_accessor :master, :half_correct, :full_correct
	
	def initialize
		@x = 4 #length of secret code
		@options = [1, 2, 3, 4, 5, 6]
		@turn_number = 1
		@master = computer_generate_code
		#welcome_introduction
	end

	def computer_generate_code
		@code = []
		@x.times { @code << @options.sample }
		return @code
	end

	def new_turn
		@turn_number += 1
	end

	def check_answer(guess)
		@half_correct = 0
		@full_correct = 0
		minor = []
		cheater_exact = {}
		cheater_partial = []
		@master.each { |each| minor << each }
		for i in 0...@x
			if minor.include? guess[i]
				@half_correct += 1 
				dupe = minor.find_index(guess[i])
				minor[dupe] = "x" 
				cheater_partial << guess[i]
			end
			if @master[i] == guess[i]
				cheater_exact[i] = @master[i]
				cheater_partial.delete_at(cheater_partial.index(@master[i]) || cheater_partial.length)
				@half_correct -= 1
				@full_correct += 1
			end
		end
	end


end


#game = MastermindGame.new
