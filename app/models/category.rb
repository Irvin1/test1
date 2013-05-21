class Category < ActiveRecord::Base
  attr_accessible :name
  has_and_belongs_to_many :articles
  
  validates :name, :presence => true
  validates :name, length: {minimum: 2, maximum: 20}
end
