class Vote < ActiveRecord::Base
   attr_accessible :like, :love, :item_id, :user_id

   belongs_to :user
   belongs_to :item

   require 'mechanize'

   def send_like_to_predict
   	a = Mechanize.new
	url = "http://ec2-23-22-86-95.compute-1.amazonaws.com:8000/actions/u2i.json"
	params = {
		"pio_appkey" => "UKG01Nnn6pjEk4WZ7oBO2dlwISHMBupxam13yrUbB8xVqCWsFXkaVxefooGslVYA",
		"pio_uid" => self.user.id.to_s,
		"pio_iid" => self.item.id.to_s,
		"pio_itypes" => "item",
		"pio_action" => "rate",
		"pio_rate" => "3"
	}
	response = a.post(url, params)
	puts response.content
   end

   def send_dislike_to_predict
   	a = Mechanize.new
	url = "http://ec2-23-22-86-95.compute-1.amazonaws.com:8000/actions/u2i.json"
	params = {
		"pio_appkey" => "UKG01Nnn6pjEk4WZ7oBO2dlwISHMBupxam13yrUbB8xVqCWsFXkaVxefooGslVYA",
		"pio_uid" => self.user.id.to_s,
		"pio_iid" => self.item.id.to_s,
		"pio_itypes" => "item",
		"pio_action" => "rate",
		"pio_rate" => "1"
	}
	response = a.post(url, params)
	puts response.content
   end

    def send_love_to_predict
   	a = Mechanize.new
	url = "http://ec2-23-22-86-95.compute-1.amazonaws.com:8000/actions/u2i.json"
	params = {
		"pio_appkey" => "UKG01Nnn6pjEk4WZ7oBO2dlwISHMBupxam13yrUbB8xVqCWsFXkaVxefooGslVYA",
		"pio_uid" => self.user.id.to_s,
		"pio_iid" => self.item.id.to_s,
		"pio_itypes" => "item",
		"pio_action" => "rate",
		"pio_rate" => "5"
	}
	response = a.post(url, params)
	puts response.content
   end

end
