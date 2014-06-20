class MoviesController < ApplicationController
	require 'open-uri'
	require 'nokogiri'

	def index
		# @movie_link = Movie.populate_db
		@movies = Movie.order('rating desc')

		# @movies.each do |movie|
		# 	movie.get_imdb
		# end
		# @movies.each do |movie|
		# 	movie.find_imdb if movie.imdb.nil?
		# end

		# @movies.each do |movie|
		# 	movie.get_rating if movie.imdb
		# end


	end
end