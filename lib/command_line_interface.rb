require_relative "../lib/api_communicator.rb"

def welcome
  puts "Hello!"
end

def character_name
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)
  character_hash["results"].map {|hashresult| hashresult["name"].downcase}
end
# binding.pry

def get_character_from_user
  puts "please enter a character"
  user_input = gets.chomp.downcase
    if character_name.include?(user_input)
      user_input
    else
      puts "Wrong Person"
    exit
    end
end
