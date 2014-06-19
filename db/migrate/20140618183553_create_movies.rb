class CreateMovies < ActiveRecord::Migration
  def change
  	create_table :movies do |t|
  		t.string :title
  		t.string :source
  		t.string :year
  		t.string :image
  		t.string :rating
  	end
  end
end
