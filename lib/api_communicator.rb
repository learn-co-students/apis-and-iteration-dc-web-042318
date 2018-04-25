require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)
  film_urls = find_film_urls(character_hash, character)
  films_hash = find_film_hashes(film_urls)
end

def find_film_urls(character_hash, character)
  # iterate over the character hash to find the collection of
  # film urls for the given character
  film_urls = []
  character_hash.fetch("results").each do |result|
    if result["name"].downcase == character.downcase
      # collect film API urls
      film_urls = result["films"]
    end
  end
  film_urls
end

def find_film_hashes(film_urls)
  #web request each URL to get the info for that film and store it in
  #the film hash array
  films_hash = []
  film_urls.each do |film|
    film_request = RestClient.get(film)
    film_hash = JSON.parse(film_request)
    films_hash.push(film_hash)
  end
  films_hash
end


def parse_character_movies(films_hash, character)
  #check if films_hash is empty, return message
  if films_hash ==[]
    puts "No movies found for character"
  else
  #returns movie info
    puts "\n\n#{character} appears in the following films:\n\n"
    films_hash.each do |film_hash|
      puts "Title: #{film_hash.fetch('title')}"
      puts "Episode: #{film_hash.fetch('episode_id')}"
      puts "Release: #{film_hash.fetch('release_date')}"
      puts "Director: #{film_hash.fetch('director')}"
      puts "\n"
    end
  end
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash, character)
end
