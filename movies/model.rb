require 'open-uri'

before_save :get_poster, if: :poster_url_changed?

def poster_url
  super || "http://via.placeholder.com/210x315?text=#{URI.escape(self.title)}"
end

def get_poster
  if self.title.blank?
    self.poster_url = nil
  else
    movie_search_url = 'https://api.themoviedb.org/3/search/movie?api_key=e9743662f5a39568d8e25225f2c97e09&language=en-US'
    movie_search_url += "&query=#{self.title}"
    puts movie_search_url
    data = JSON.parse(open(URI.escape(movie_search_url)).read) rescue nil
    if data
      path = data['results'][0]['poster_path']
      self.poster_url = "http://image.tmdb.org/t/p/w300/#{path}"
    end
  end
end
