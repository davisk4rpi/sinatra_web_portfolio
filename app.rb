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
	guess = [params['first'].to_i, 
					 params['second'].to_i, 
					 params['third'].to_i, 
					 params['fourth'].to_i]
	redirect to('/winner') if guess == session["code"] 
	session["guesses"] << guess
	session['game'].check_answer(guess)
	partial = session['game'].half_correct
	exact = session['game'].full_correct
	erb :mastermind_game, :locals => {:guesses => session["guesses"], :answer => session["code"], :exact => exact, :partial => partial}
end


