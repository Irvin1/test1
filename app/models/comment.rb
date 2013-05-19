class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :article
  attr_accessible :articleid, :content, :username
  
  validates :content, :presence => true
  validates :content, length: {minimum: 2, maximum: 100}
end
