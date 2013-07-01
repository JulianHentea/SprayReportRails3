class Tag < ActiveRecord::Base
  attr_accessible :name
  
  has_many :taggings
  has_many :posts, through: :taggings
  
  def to_s
    name
  end
end