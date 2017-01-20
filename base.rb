require 'sinatra'
require 'sinatra/reloader'
require_relative 'lib/caesar.rb'
require_relative 'lib/mastermind.rb'

get '/' do
	erb :index
end

get '/caesar.erb' do
	string = params["string"]
	shift = params["shift"].to_i
	new_string = caesar_cipher(string, shift)
	erb :caesar, :locals => {:string => new_string}
end

get '/mastermind.erb' do
	string = params["string"]
	shift = params["shift"].to_i
	new_string = caesar_cipher(string, shift)
	erb :caesar, :locals => {:string => new_string}
end
