require 'sinatra'
require "http"
require 'json'
require "base64"
require 'twilio-ruby'

client_id = 'staging-grofers'
client_secret = '51e6d096-56f6-40b4-a2b9-9e0f8fa704b8'

registered_users = {
	"9810181713" => '77cb89f5-35da-4011-92f1-deffd0972200',
	"7838121295" => 'e7fdbe44-2c8d-43ca-8c17-269b2d78cdfa'
}

def send_twilio_message(to_number, message)
	account_sid = 'ACce698a0c8a05f3cb16eb6f928faed8ea'
	auth_token = '0b03d049efc458da06e4b702c6347bb6'

	# set up a client to talk to the Twilio REST API
	@client = Twilio::REST::Client.new account_sid, auth_token
	@client.account.messages.create({
		:from => '+12058815273',
		:to => to_number,
		:body => message,
	})
end

def checkBal(me)
	#puts registered_users
	check_balance_api_url = 'https://trust-uat.paytm.in/wallet-web/checkBalance'
	response = HTTP.headers(:ssotoken => '77cb89f5-35da-4011-92f1-deffd0972200').post(check_balance_api_url)
	if response.code != 200
		"Failed bal req #{response.code}"
	else
		puts "before tw"
		send_twilio_message("+91"<<me, JSON.parse(response.body)['response']['amount'])
	end
	"all ok1"
end

get '/' do
	# content_type :json
	mobile_number = params['from']
	message = params['message']
	tokens = message.split()
	if tokens[0].downcase == "paytm"
		case tokens[1].downcase
		when 'send', 'pay'
			puts 'call API 1'
		when 'balance', 'bal'
			checkBal(mobile_number)
		end
	end

	# tokens.length.times do | token |
	# 	puts tokens[token]
	# end
	# tokens
	# { :message => "#{params['message']}"}.to_json
end

get '/getState' do
	email = params['email']
	phone = params['mobile_number']
	get_state_hash = {
		:email => email,
		:phone => phone,
		:clientId => client_id,
		:scope => 'wallet',
		:responseType => 'token'
	}
	response = HTTP.post("https://accounts-uat.paytm.com/signin/otp", :body => get_state_hash.to_json)
	if response.code != 200
		"Failed response"
	else
		response.body
	end
end

get '/getToken' do
	basic_auth = "Basic "<<Base64.strict_encode64("#{client_id}:#{client_secret}")
	print basic_auth
	otp = params['otp']
	state = params['state']
	get_token_hash = {
		:otp => otp,
		:state => state
	}
	print get_token_hash.to_json
	response = HTTP.headers("Authorization" => basic_auth, "Content-Type" => 'application/json').post('https://accounts-uat.paytm.com/signin/validate/otp', :body => get_token_hash.to_json)
	if response.code != 200
		"Failed token request"
	else
		response.body
	end
end

get '/transfer' do
	from = params['from']
	to = params['to']
	amt = params['amt'].to_i

	query = {
		:request => {
			:isToVerify => 0,
			:isLimitApplicable => 0,
			:payeeEmail => "",
			:payeeMobile => to,
			:payeeCustId => "",
			:amount => amt,
			:currencyCode => "INR",
			:comment => "Loan"
		},
		:ipAddress => "127.0.0.1",
		:platformName => "PayTM",
		:operationType => "P2P_TRANSFER"
	}

	response = HTTP.headers(:ssotoken => registered_users[from]).post('https://trust-uat.paytm.in/wallet-web/wrapper/p2pTransfer', :body => query.to_json)
	if response.code != 200
		"Failed Transfer request"
	else
		response.body
	end
end

get '/checkBal' do
	#of = params['of']
	# trust-uat
	#puts registered_users[of]<<"\n"
	check_balance_api_url = 'https://trust-uat.paytm.in/wallet-web/checkBalance'
	response = HTTP.headers(:ssotoken => "e7fdbe44-2c8d-43ca-8c17-269b2d78cdfa").post(check_balance_api_url)
	if response.code != 200
		"Failed bal req #{response.code}"
	else
		response.body
	end
end
