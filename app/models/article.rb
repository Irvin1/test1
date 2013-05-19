class Article < ActiveRecord::Base
  has_many :comments, foreign_key: "articleid", dependent: :destroy
  belongs_to :user
  
  attr_accessible :title, :author, :text
  validates :title, :text, :presence => true
  validates :title, length: {minimum: 2, maximum: 20}
  validates :text, length: {minimum: 5}
end
