require 'rest-client'
require 'json'

def get_character_movies_from_api
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  JSON.parse(all_characters)
end

def filter_char(hash, character)
  hash.fetch('results').each do |char|
    if char.fetch('name').downcase == character
      return char.fetch('films').map{ |m| JSON.parse(RestClient.get(m)) }
    else
      return 'error'
    end
  end
end

def parse_character_movies(films_hash)
  sorted_films = films_hash.map { |m| "#{m.fetch('episode_id')} #{m.fetch('title')} (#{m.fetch('release_date').split('-')[0].to_s})" }.sort
  sorted_films.each_with_index.map { |m, i| m[0] = (i + 1).to_s }
  puts sorted_films
end

def show_character_movies(character)
  hash = get_character_movies_from_api
  films_hash = filter_char(hash, character)
  if films_hash == 'error'
    puts 'No such character exists'
  else
    parse_character_movies(films_hash)
  end
end
