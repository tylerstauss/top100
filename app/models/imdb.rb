require 'json'

module IMDB
  class Client
    include HTTParty
    base_uri 'http://www.omdbapi.com'

    def get_rating(id)
       self.class.get("/?i=#{id}&r=json"
        )
    end

    
  end
end

