require 'twilio-ruby'

account_sid = 'AC429dce9f5eab5b640f7eaa8e8003840a'
auth_token = '22387d9c7afa98da3b40b55eeb18778e'
$twilio_phone_number = "+16477242096"

$twilio_client = Twilio::REST::Client.new account_sid, auth_token

#Twilio.configure do |config|
#  config.account_sid = account_sid
#  config.auth_token = auth_token
#end