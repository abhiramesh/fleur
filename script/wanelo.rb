require 'mechanize'
require 'json'
require 'csv'

a = Mechanize.new

CSV.open('all_wanelo_items.csv', 'ab') do |csv|
	#csv << ["Wanelo Link", "Item Name", "Store Name", "Store Link", "Image Url"]
	csv << []
	(81..119).each do |page|
		puts "***************************"
		puts page
		puts "***************************"
		begin
			a.get('http://wanelo.com/trending/' + page.to_s)
		rescue Mechanize::ResponseCodeError => e
				puts e
		end
		a.page.search("//div[@class='product-thumbnail-container']").each do |item|
			row = []
		 	wanelo_link = item.search("./a/@href").text
		 	row << wanelo_link
		 	begin
		 		a.get("http://www.wanelo.com" + wanelo_link)
		 	rescue Mechanize::ResponseCodeError => e
				puts e
		 	end
		 	a.page.search("//div[@class='container product-attribution-show']").each do |detail|
		 		puts name = detail.search("./div[@class='products-show-title']/div[@class='products-show-title-inner-container']/h2/span[@itemprop='name']").text
		 		row << name
		 		store_name = detail.search("./div[@class='products-show-poster']/div[@class='products-show-poster-details']/a").text
		 		row << store_name
		 		store_link = detail.search("./div[@class='products-show']/div[@class='products-show-left-pane']/div[@class='products-show-image']/a/@href").text
		 		row << store_link
		 		image_url = detail.search("./div[@class='products-show']/div[@class='products-show-left-pane']/div[@class='products-show-image']/a/img/@src").text
		 		row << image_url
		 	end
		 	csv << row
		 	sleep 3
		 end
	sleep 10
	end
end