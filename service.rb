require 'sinatra'
require 'json'

get '/' do
	content_type :json
	{ :message => "#{params['message']}"}.to_json
end
