class Article < ActiveRecord::Base
  belongs_to :movie
  
  attr_accessible :title, :author, :text
  validates :title, :text, :presence => true
  validates :title, length: {minimum: 2, maximum: 20}
  validates :text, length: {minimum: 5}
end
