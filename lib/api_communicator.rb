require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  #make the web request
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)
  character_profiles = character_hash.fetch('results')
select_just_one_character = character_profiles.find {|x| x["name"].downcase == character}

  films_urls_array = select_just_one_character["films"]
  hash_of_unparsed_films_data = films_urls_array.map do |url|
    movie_info = RestClient.get(url)
    parsed_movie_info = JSON.parse(movie_info)
    parsed_movie_info["title"]
  end



  # iterate over the character hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.end


end

def parse_character_movies(films_hash)
  # some iteration magic and puts out the movies in a nice list
  #films_hash["film"]
  #films_hash =get_character_movies_from_api.each do |film|
  #  puts "#{film}"
  puts films_hash


end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end

#films_hash = get_character_movies_from_api
## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
