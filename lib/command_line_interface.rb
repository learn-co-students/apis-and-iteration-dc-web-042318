def welcome
  puts 'Welcome, who is your favorit Star Wars character?'
end

def get_character_from_user
  puts "please enter a character"
  gets.chomp.downcase
end