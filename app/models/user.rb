class User < ActiveRecord::Base
  has_many :articles, foreign_key: "author", dependent: :destroy, primary_key:"name"
  has_secure_password
  attr_accessible :email, :name, :password, :password_confirmation, :admin
  
  validates :name, :email, :presence => true
  validates :email, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create }
  validates :name, :email, :uniqueness => true
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true
  
  def self.findNoArticles(username)
	return Article.count(:conditions => ["author = ?", username])
  end
  

end
