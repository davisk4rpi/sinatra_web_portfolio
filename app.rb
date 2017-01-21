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
	session["guesses"] = Array.new
	erb :mastermind
end

before '/' do
end

get '/mastermind/game' do
	session["guesses"] << params['first'] + params['second'] + params['third'] + params['fourth']
	erb :mastermind_game, :locals => {:guesses => session["guesses"]}
end


