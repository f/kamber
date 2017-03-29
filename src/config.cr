module BlogWide
  @@BLOG_TITLE = "Ex Chaos Simplicitas :: Thinking Code"
  @@BLOG_DESC = "Tommaso Patrizi personal views on tech and universe"
  @@GOOGLE_ANALYTICS = "UA-32444807-1"

  def self.title 
    @@BLOG_TITLE
  end

  def self.desc
    @@BLOG_DESC
  end

  def self.ga
    @@GOOGLE_ANALYTICS
  end
end

require "kamber-theme-default"
