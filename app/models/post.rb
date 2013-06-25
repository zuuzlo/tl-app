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

  after_validation :generate_slug

  def generate_slug
    #remove stop words 
    slug = self.title.dup
    #stop_words = stopwords
    words = slug.scan(/\w+/)

    slug_words = words.select { |word| !STOP_WORDS.include?(word)}

    if slug_words.size > 0

      slug = slug_words.join(' ')
    else
      slug = self.title.dup
    end
    
    #slug = self.title.dup

    #blow away apostrophes
    slug.gsub! /['`]/,""

    # @ --> at, and & --> and
    slug.gsub! /\s*@\s*/, " at "
    slug.gsub! /\s*&\s*/, " and "

    #replace all non alphanumeric, underscore or periods with underscore
    slug.gsub! /\s*[^A-Za-z0-9\.\-]\s*/, '_'

     #convert double underscores to single
    slug.gsub! /_+/,"_"

     #strip off leading/trailing underscore
    slug.gsub! /\A[_\.]+|[_\.]+\z/,""

    slug.downcase!
     
    count = 0
    final_slug = slug
    test = nil
    test = Post.where("slug = ?",final_slug).first

    #test = Post.find_by_slug(self.slug)
    while test && (self.new_record? || test != self)
      count += 1
      final_slug = slug + "_" + count.to_s
      
      test = nil
      test = Post.where("slug = ?",final_slug).first

      #test = Post.find_by_slug(self.slug)
    end
    self.slug = final_slug
  end

  def to_param
    self.slug
  end

  def total_votes
    self.votes.where(vote: true).size - self.votes.where(vote: false).size
  end
end 