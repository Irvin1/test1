class User < ActiveRecord::Base
  has_many :articles, foreign_key: "author", dependent: :destroy, primary_key:"name"
  has_many :comments, foreign_key: "username", dependent: :destroy
  has_secure_password
  attr_accessible :email, :name, :password, :password_confirmation, :admin, :avatar
  
  has_attached_file :avatar, :url  => "/assets/avatars/:id/:basename.:extension",
                  :path => ":rails_root/public/assets/avatars/:id/:basename.:extension",
				:default_url => "/assets/avatars/missing.jpg"
				
  #validates_attachment_presence :avatar
  validates_attachment_size :avatar, :less_than => 5.megabytes
  validates_attachment_content_type :avatar, :content_type => ['image/jpeg', 'image/png']
  
  validates :name, :email, :presence => true
  validates :email, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create }
  validates :name, :email, :uniqueness => true
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true
  
  def self.findNoArticles(username)
	return Article.count(:conditions => ["author = ?", username])
  end
  
  def self.findNoComments(username)
	return Comment.count(:conditions => ["username = ?", username])
  end

end
