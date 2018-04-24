require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)
  character_name = character_hash["results"].find {|hashresult| hashresult["name"].downcase == character}
  # films_arr = character_name["films"]
  # films_arr.map do |url|
  #   movie = RestClient.get(url)
  #   starwars = JSON.parse(movie)
  #   starwars["title"]
  # end
end

def character_films(character)
  character_name = get_character_movies_from_api(character)
  films_arr = character_name["films"]
  films_arr.map do |url|
    movie = RestClient.get(url)
    starwars = JSON.parse(movie)
    starwars["title"]
  end
end

def parse_character_movies(films_hash)
  puts films_hash
end

def show_character_movies(character)
  films_hash = character_films(character)
  parse_character_movies(films_hash)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
