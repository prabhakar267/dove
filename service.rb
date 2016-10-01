require 'sinatra'
require "http"
require 'json'
require "base64"

get '/' do
	# content_type :json
	mobile_number = params['mobile']
	message = params['message']
	tokens = message.split()
	
	if tokens[0].downcase == "paytm"
		case tokens[1]
		when "send", "pay"
			puts "call API 1"
		when "balance", "bal"
			puts "call API 2" 
		end
	end

	# tokens.length.times do | token |
	# 	puts tokens[token]
	# end
	# tokens
	# { :message => "#{params['message']}"}.to_json
end
