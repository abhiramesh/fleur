require 'mechanize'
require 'json'

# a = Mechanize.new
# url = "http://3i46.localtunnel.com/api/v1/signup"
# 	params = {
# 		"email" => 'test@test.com',
# 		"password" => "password"
# 	}
# response = a.post(url, params)
# puts response.content


a = Mechanize.new
url = "http://4zvq.localtunnel.com/api/v1/like"
	params = {
		"user_token" => '0cf1ecd95261f03adfe065fb010c8fad'
	}
response = a.post(url, params)
puts response.content

url = "http://4zvq.localtunnel.com/api/v1/dislike"
	params = {
		"user_token" => '0cf1ecd95261f03adfe065fb010c8fad'
	}
response = a.post(url, params)
puts response.content

url = "http://4zvq.localtunnel.com/api/v1/love"
	params = {
		"user_token" => '0cf1ecd95261f03adfe065fb010c8fad'
	}
response = a.post(url, params)
puts response.content