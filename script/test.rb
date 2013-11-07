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


# a = Mechanize.new
# url = "http://4yv2.localtunnel.com/api/v1/feed_items"
# 	params = {
# 		"user_token" => "a0eaca984a22220a1962e11b2799b5c0"
# 	}
# response = a.post(url, params)
# puts response.content

a = Mechanize.new
b = []
CSV.foreach('wan2.csv') do |row|
	puts row[1]
	b << row[1]
	Item.create(:name => row[1].squish, :image => row[4], :src_url => row[3], :brand => row[2])
	break if b.length == 50
end