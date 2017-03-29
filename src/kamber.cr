require "./kamber/*"

require "markdown"
require "yaml"
require "kemal"
require "./config"

module Kamber
  @@posts = YAML.parse_all File.read("./posts/posts.yml")

  def self.posts
    @@posts
  end

  def self.post_item(file)
    post = {} of String => String
    contents = ""
    @@posts.each do |_post|
      puts _post
      _post = _post.as_h.as(Hash)
      if _post.has_key? "file"
        if (_post["file"].as(String).ends_with?("#{file}.md".as(String)))
          post = _post
          contents = File.read(_post["file"].as(String))
        end
      end
    end
    theme_item(post, contents)
  end

  get "/" do
    theme_index
  end

  get "/style/:path" do |env|
    env.response.content_type = "text/css"
    File.read theme_style(env.params.query["path"])
  end

  get "/script/:path" do |env|
    env.response.content_type = "application/javascript"
    File.read theme_script(env.params.query["path"])
  end

  get "/:post" do |env|
    post_item(env.params.url["post"])
  end

  get "/categories/:category/:post" do |env|
    category = env.params.url["category"].as(String)
    post = env.params.url["post"].as(String)
    post_item(category + "/" + post)
  end

  get "/subcategories/:category/:subcategory/:post" do |env|
    category = env.params.url["category"].as(String)
    subcategory = env.params.url["subcategory"].as(String)
    post_name = env.params.url["post"].as(String)
    post_item(category + "/" + subcategory + "/" + post_name)
  end
  Kemal.run
end
