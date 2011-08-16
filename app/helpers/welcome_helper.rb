module WelcomeHelper

def get_rss
  #require on demand
  require 'open-uri'
  require 'rss'
  
  rss = ::RSS::Parser.parse(open("http://blog.samecup.com/feeds/posts/default?alt=rss"))
end

end
