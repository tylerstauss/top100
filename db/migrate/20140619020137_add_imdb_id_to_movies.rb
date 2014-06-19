class AddImdbIdToMovies < ActiveRecord::Migration
  def change
  	change_table :movies do |t|
  		t.string :imdb
  	end
  end
end
