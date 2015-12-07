require "./kamber/*"

require "markdown"
require "yaml"
require "kemal"
require "./config"

$posts = YAML.load_all File.read("./posts/posts.yml")

module Kamber
  get "/" do
    render "src/kamber/views/index.ecr"
  end

  get "/:post" do |env|
    post = {} of String => String
    contents = ""
    $posts.each do |_post|
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
end
