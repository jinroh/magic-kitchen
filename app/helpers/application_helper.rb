module ApplicationHelper
  
  def title(title, tag=nil)
    title = h(title)
    @title.unshift title
    content_tag(tag, title) if tag
  end
  
end
