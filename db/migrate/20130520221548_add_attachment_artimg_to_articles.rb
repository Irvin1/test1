class AddAttachmentArtimgToArticles < ActiveRecord::Migration
  def self.up
    change_table :articles do |t|
      t.attachment :artimg
    end
  end

  def self.down
    drop_attached_file :articles, :artimg
  end
end
