class User < ActiveRecord::Base
  has_secure_password
  
  has_many  :posts, order: 'created_at desc'
  has_many  :comments
  validates :username, presence: true, length: {minimum: 4}, uniqueness: true
  validates :password, presence: true, on: :create, length: {minimum: 4}

  #after_validation :generate_slug

  def generate_slug
    slug = self.title.dup
    
    
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
    test = User.where("slug = ?",final_slug).first

    #test = Post.find_by_slug(self.slug)
    while test && (self.new_record? || test != self)
      count += 1
      final_slug = slug + "_" + count.to_s
      
      test = nil
      test = User.where("slug = ?",final_slug).first

      #test = Post.find_by_slug(self.slug)
    end
    self.slug = final_slug
  end

  #def to_param
    #self.slug
  #end

  #TODO to_param
end 