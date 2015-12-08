require "./kamber/*"

require "common_mark"
require "yaml"
require "kemal"
require "./config"

$posts = YAML.load_all File.read("./posts/posts.yml")

def post_item(file)
  post = {} of String => String
  contents = ""
  $posts.each do |_post|
    _post = _post as Hash
    if _post.has_key? "file"
      puts file
      if (_post["file"] as String).ends_with?("#{file}.md" as String)
        post = _post
        contents = File.read(_post["file"] as String)
      end
    end
  end
  render "src/kamber/views/post.ecr"
end

module Kamber

  get "/" do
    render "src/kamber/views/index.ecr"
  end

  get "/style/:path" do |env|
    env.content_type = "text/css"
    File.read "src/kamber/static/css/#{env.params["path"]}"
  end

  get "/:post" do |env|
    post_item(env.params["post"])
  end

  get "/:category/:post" do |env|
    category = env.params["category"] as String
    post = env.params["post"] as String
    post_item(category + "/" + post)
  end

  get "/:category/:subcategory/:post" do |env|
    category = env.params["category"] as String
    subcategory = env.params["subcategory"] as String
    post_name = env.params["post"] as String
    post_item(category + "/" + subcategory + "/" + post_name)
  end

end
