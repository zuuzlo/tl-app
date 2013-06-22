class Post < ActiveRecord::Base
  
  belongs_to  :user
  has_many    :posts_categories
  has_many    :categories, through: :posts_categories
  has_many    :comments, order: 'created_at desc'
  has_many    :votes, as: :voteable
  # has_many    :postcomments
  # has_many    :comments, through: :postcomments
  validates :title, presence: true
  validates :url, presence: true, uniqueness: true

  def total_votes
    self.votes.where(vote: true).size - self.votes.where(vote: false).size
  end
end 