require "./kamber/*"

require "markdown"
require "yaml"
require "kemal"
require "./config"

module Kamber

  get "/" do
    posts = YAML.load_all File.read("./posts/posts.yml")
    render "src/kamber/views/index.ecr"
  end

  get "/:post" do |env|
    posts = YAML.load_all File.read("./posts/posts.yml")
    post = {} of String => String
    contents = ""
    posts.each do |_post|
      _post = _post as Hash
      if _post.has_key? "file"
        if (_post["file"] as String).ends_with?("#{env.params["post"]}.md" as String)
          post = _post
          contents = File.read(_post["file"] as String)
        end
      end
    end
    render "src/kamber/views/post.ecr"
  end

  get "/style/:path" do |env|
    env.content_type = "text/css"
    File.read "src/kamber/static/css/#{env.params["path"]}"
  end
end
