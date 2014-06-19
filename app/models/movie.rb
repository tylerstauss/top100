class Movie < ActiveRecord::Base
	attr_accessible :title, :type, :year, :image, :rating, :imdb
	validates_uniqueness_of :title

	def self.populate_db
		url = 'http://thepiratebay.se/top/201'
		doc = Nokogiri::HTML(open(url))
		@movie_link = []
		doc.css('.detName').each do |movie|
			text = movie.at_css('.detLink').text
			text.delete!('()[]')
			link = movie.at_css('.detLink').map { |link| link }[0][1]
			link = "http://thepiratebay.se#{link}"
			content = /(.*?)(20[0-9]{2})/.match(text)
			if content
				title = content[1]
				title = Movie.clean_title(title)
				date = content[2]
			else
				title = text
				title = Movie.clean_title(title)
				date = '2014'
			end
			new_movie = Movie.new(title: title)
			new_movie.link = link
			new_movie.year = date
			new_movie.save
		end
	end

	def self.clean_title(title)
		if title.match(/\./)
			title.gsub('.', ' ') .strip.downcase
		else
			title.strip.downcase
		end
	end

	def get_rating
		client = IMDB::Client.new
		response = client.get_rating(self.imdb)
		result = JSON.parse(response)
		self.rating = result['imdbRating']
		p result['Poster']
		self.image = result['Poster'] unless result['Poster'] == 'N/A'
		self.image = '' if self.image == 'N/A'
		self.save
	end


	def get_imdb
		url = self.link
		url.gsub!('[', '%5B')
		url.gsub!(']', '%5D')
		doc = Nokogiri::HTML(open(url.strip))
		response = doc.css('body').text
		type = 'CAM' if response.match('CAM')
		type = 'DVDSCR' if response.match('DVDSCR')
		type = 'TS' if response.match('TS')
		type = 'BRRip' if response.match('BRRip')
		type = 'HDRip' if response.match('HDRip')
		type = 'WEBRip' if response.match('WEBRip')

		imdb_id = response.match(/(tt[0-9]{7})/)
		self.imdb = imdb_id[1] unless imdb_id.nil?
		self.source = type
		self.save
	end

end