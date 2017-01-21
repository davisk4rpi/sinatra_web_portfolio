require 'sinatra'
require 'sinatra/reloader'
require_relative 'lib/caesar.rb'
require_relative 'lib/mastermind.rb'

configure do
  enable :sessions
  set :session_secret, "secret"
end

get '/' do
	erb :index
end

get '/caesar.erb' do
	string = params["string"]
	shift = params["shift"].to_i
	new_string = caesar_cipher(string, shift)
	erb :caesar, :locals => {:string => new_string}
end

get '/mastermind' do
	session['game'] = MastermindGame.new
	session["code"] = session['game'].master
	session["guesses"] = Array.new
	erb :mastermind
end

get '/mastermind/game' do
	guess = [params['first'].to_i, params['second'].to_i, params['third'].to_i, params['fourth'].to_i]
	redirect to('/mastermind/winner') if guess == session["code"] 
	display_move (guess)
	erb :mastermind_game, :locals => {:guesses => session["guesses"]}
end

get '/mastermind/loser' do 
	string = "Ouch! You aren't as good at this as I thought."
	erb :mastermind_end, :locals => {:response => string}
end

get '/mastermind/winner' do
	string = "Hey! You are way better at this as I thought."
	erb :mastermind_end, :locals => {:response => string}
end

helpers do
	def display_move (guess)
		session['game'].check_answer(guess)
		redirect to ('/mastermind/loser') if session['game'].turn_number > 11
		string = guess.join("") + " : "
		partial = session['game'].half_correct
		exact = session['game'].full_correct
		exact.times {string += "\u26AB"}
		partial.times {string += "\u26AA"}
		session["guesses"] << "Turn #{session['game'].turn_number} - #{string}"
		return string
	end
end



