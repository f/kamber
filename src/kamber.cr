require "./kamber/*"

require "markdown"
require "kemal"
require "./config"

module Kamber
  get "/" do
    post_title = "hey"
    post_text = File.read "posts/example-post.md"
    render "src/kamber/views/index.ecr"
  end
end
