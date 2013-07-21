class Message < ActiveRecord::Base
  default_scope :order => "read ASC"
  attr_accessible :content, :read, :receiver_name, :sender_name
  belongs_to :user
  belongs_to :user
  
  validates :receiver_name, :content, :presence => true
  
  validates :content, length: {minimum: 3, maximum: 35}
  validate :receiver_exists
  validate :receiver_not_self
  
  def self.unread(name,current)
	
	messages = Message.where("sender_name = ? AND receiver_name = ?", name, current)
	messages.each do |mm|
		if !mm.read
			return true
		end
	end
	return false
  end
  
  def receiver_exists
	if !User.find_by_name(receiver_name)
      errors[:base] << "Recipent doesn't exist"  
	  #errors.add(:receiver_name, "must exist")
    end
  end
  
  def receiver_not_self
	if receiver_name == sender_name
	  errors[:base] << "You can't send a message to yourself"  
    end
  end
  
end
