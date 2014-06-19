class AddLinkToMovie < ActiveRecord::Migration
  def change
  	change_table :movies do |t|
  		t.string :link
  	end
  end
end
