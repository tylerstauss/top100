class AddAttachmentPictureToMovies < ActiveRecord::Migration
  def self.up
    change_table :movies do |t|
      t.attachment :picture
    end
  end

  def self.down
    drop_attached_file :movies, :picture
  end
end
