class Article < ActiveRecord::Base
  has_many :comments, foreign_key: "articleid", dependent: :destroy
  belongs_to :user
  
  attr_accessible :title, :author, :text, :artimg
  has_attached_file :artimg, :url  => "/assets/articleimgs/:id/:basename.:extension",
                  :path => ":rails_root/public/assets/articleimgs/:id/:basename.:extension",
				:default_url => "/assets/articleimgs/missing.jpg"
				
  #validates_attachment_presence :artimg
  validates_attachment_size :artimg, :less_than => 5.megabytes
  validates_attachment_content_type :artimg, :content_type => ['image/jpeg', 'image/png']
  
  validates :title, :text, :presence => true
  validates :title, length: {minimum: 2, maximum: 20}
  validates :text, length: {minimum: 5}
end
