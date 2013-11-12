require 'mechanize'
require 'json'
require 'csv'

# a = Mechanize.new
# url = "http://3i46.localtunnel.com/api/v1/signup"
# 	params = {
# 		"email" => 'test@test.com',
# 		"password" => "password"
# 	}
# response = a.post(url, params)
# puts response.content


a = Mechanize.new
url = "http://5ayn.localtunnel.com/api/v1/liked_items/?page=1"
	params = {
		"user_token" => "86542e337e68f3679b8b5879b81520ba"
	}
response = a.get(url, params)
puts response.content

# a = Mechanize.new
# b = []
# CSV.foreach('wan2.csv') do |row|
# 	puts row[1]
# 	b << row[1]
# 	Item.create(:name => row[1].squish, :image => row[4], :src_url => row[3], :brand => row[2])
# 	#break if b.length == 50
# end