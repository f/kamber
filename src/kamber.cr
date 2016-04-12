require "./kamber/*"

require "markdown"
require "yaml"
require "kemal"
require "./config"

$posts = YAML.parse File.read("./posts/posts.yml")

def post_item(file)
  post = {} of String => String
  contents = ""
  $posts.each do |_post|
    puts _post
    _post = _post.as_h as Hash
    if _post.has_key? "file"
      if (_post["file"] as String).ends_with?("#{file}.md" as String)
        post = _post
        contents = File.read(_post["file"] as String)
      end
    end
  end
  theme_item(post, contents)
end

module Kamber
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
    post_item(env.params.query["post"])
  end

  get "/:category/:post" do |env|
    category = env.params.query["category"] as String
    post = env.params.query["post"] as String
    post_item(category + "/" + post)
  end

  get "/:category/:subcategory/:post" do |env|
    category = env.params.query["category"] as String
    subcategory = env.params.query["subcategory"] as String
    post_name = env.params.query["post"] as String
    post_item(category + "/" + subcategory + "/" + post_name)
  end
  Kemal.run
end
