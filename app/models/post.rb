class Post
  attr_accessor :content
  
  validates_length_of :content, :maximum => 140, :message => "140 characters max"
  
  timeline :attributes => [:id, :content]
           :verb => "posts"
end
