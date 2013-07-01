class Post < ActiveRecord::Base
  attr_accessible :title, :content, :name, :tag_list, :image
  belongs_to :user

  has_many :comments
  has_many :taggings
  has_many :tags, through: :taggings
  
  has_attached_file :image

  validates :user_id, presence: true
   validates :title, presence: true
  validates :content, presence: true

  default_scope order: 'posts.created_at DESC'

  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id", 
          user_id: user.id)
  end

    # def tag_list
    #   return self.tags.join(", ")
    # end
    # 
    # def tag_list=(tags_string)
    #   self.taggings.destroy_all
    # 
    #   tag_names = tags_string.split(",").collect{|s| s.strip.downcase}.uniq
    # 
    #   tag_names.each do |tag_name|
    #     tag = Tag.find_or_create_by_name(tag_name)
    #     tagging = self.taggings.new
    #     tagging.tag_id = tag.id
    #   end
    # end

  def self.tagged_with(name)
    Tag.find_by_name!(name).posts
  end
  
  def self.tag_counts
    Tag.select("tags.*, count(taggings.tag_id) as count").
      joins(:taggings).group("taggings.tag_id")
  end
  
  def tag_list
    tags.map(&:name).join(", ")
  end
  
  def tag_list=(names)
    self.tags = names.split(",").map do |n|
      Tag.where(name: n.strip).first_or_create!
    end
  end
end