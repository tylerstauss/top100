class MoviesController < ApplicationController
	require 'open-uri'
	require 'nokogiri'

	def index
		# @movie_link = Movie.populate_db
		@movies = Movie.order('rating desc')
		@movies.each do |movie|
			movie.get_imdb
			# movie.find_imdb if movie.imdb.nil?
			# movie.get_rating if movie.imdb
			# movie.picture_from_url(movie.image) unless movie.image.nil? || movie.image == ''
			# p movie.picture
			
		end
	end
end