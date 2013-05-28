class User < ActiveRecord::Base
  default_scope :order => "id ASC"
  has_many :articles, foreign_key: "author", dependent: :destroy, primary_key:"name"
  has_many :comments, foreign_key: "username", dependent: :destroy, primary_key:"name"
  has_many :messages, foreign_key: "sender_name", dependent: :destroy, primary_key:"name"
  has_many :messages, foreign_key: "receiver_name", dependent: :destroy, primary_key:"name"
  has_secure_password
  attr_accessible :email, :name, :password, :password_confirmation, :admin, :avatar
  
  has_attached_file :avatar, :url  => "/assets/avatars/:id/:basename.:extension",
                  :path => ":rails_root/public/assets/avatars/:id/:basename.:extension",
				:default_url => "/assets/avatars/missing.jpg"
				
  #validates_attachment_presence :avatar
  validates_attachment_size :avatar, :less_than => 5.megabytes
  validates_attachment_content_type :avatar, :content_type => ['image/jpeg', 'image/png']
  
  validates :email, :presence => true
  validates :email, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create }
  validates :name, :email, :uniqueness => true
  validates :name, presence: true, length: {minimum: 3, maximum: 9}
  validates :password, presence: true, length: { minimum: 6 } , :on => :create
  validates :password_confirmation, presence: true , :on => :create
  
  def self.findNoArticles(username)
	return Article.count(:conditions => ["author = ?", username])
  end
  
  def self.findNoComments(username)
	return Comment.count(:conditions => ["username = ?", username])
  end

end
