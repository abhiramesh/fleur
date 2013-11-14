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
# url = "http://4m39.localtunnel.com/api/v1/liked_items/?page=1"
# 	params = {
# 		"user_token" => "86542e337e68f3679b8b5879b81520ba"
# 	}
# response = a.get(url, params)
# puts response.content

# a = Mechanize.new
# b = []
# CSV.foreach('wan2.csv') do |row|
# 	puts row[1]
# 	b << row[1]
# 	Item.create(:name => row[1].squish, :image => row[4], :src_url => row[3], :brand => row[2])
# 	#break if b.length == 50
# end

a = Mechanize.new

# (1..5).each do |id|
# url = "http://ec2-23-22-86-95.compute-1.amazonaws.com:8000/users.json"
# 	params = {
# 		"pio_appkey" => "UKG01Nnn6pjEk4WZ7oBO2dlwISHMBupxam13yrUbB8xVqCWsFXkaVxefooGslVYA",
# 		"pio_uid" => id.to_s
# 	}
# begin
# response = a.post(url, params)
# rescue Exception => e
# 	puts e.message
# end
# puts response.content
# end

url = "http://ec2-23-22-86-95.compute-1.amazonaws.com:8000/items.json"
params = {
"pio_appkey" => "UKG01Nnn6pjEk4WZ7oBO2dlwISHMBupxam13yrUbB8xVqCWsFXkaVxefooGslVYA",
"pio_iid" => item.id.to_s, 
"pio_itypes" => "item"
}
response = a.post(url, params)
puts response.content

# (1..5).each do |uid|
# 	25.times do
# 		iid = Random.new.rand(1..100)
# 		url = "http://ec2-23-22-86-95.compute-1.amazonaws.com:8000/actions/u2i.json"
# 			params = {
# 				"pio_appkey" => "UKG01Nnn6pjEk4WZ7oBO2dlwISHMBupxam13yrUbB8xVqCWsFXkaVxefooGslVYA",
# 				"pio_uid" => uid.to_s,
# 				"pio_iid" => iid.to_s,
# 				"pio_itypes" => "item",
# 				"pio_action" => "like"
# 			}
# 		begin
# 		response = a.post(url, params)
# 		rescue Exception => e
# 			puts e.message
# 		end
# 		puts response.content
# 	end
# end

		# url = "http://ec2-23-22-86-95.compute-1.amazonaws.com:8000/actions/u2i.json"
		# 	params = {
		# 		"pio_appkey" => "UKG01Nnn6pjEk4WZ7oBO2dlwISHMBupxam13yrUbB8xVqCWsFXkaVxefooGslVYA",
		# 		"pio_uid" => "1",
		# 		"pio_iid" => "30",
		# 		"pio_itypes" => "item",
		# 		"pio_action" => "like"
		# 	}
		# begin
		# response = a.post(url, params)
		# rescue Exception => e
		# 	puts e.message
		# end
		# puts response.content





url = "http://ec2-23-22-86-95.compute-1.amazonaws.com:8000/engines/itemrec/itemsimilar/topn.json"
	params = {
		"pio_appkey" => "UKG01Nnn6pjEk4WZ7oBO2dlwISHMBupxam13yrUbB8xVqCWsFXkaVxefooGslVYA",
		"pio_uid" => "1", 
		"pio_n" => "10"
	}
begin
response = a.get(url, params)
rescue Exception => e
	puts e.message
end
puts response.content
