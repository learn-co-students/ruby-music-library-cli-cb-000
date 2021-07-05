require_relative '../lib/artist.rb'
require_relative '../lib/genre.rb'
require_relative '../lib/song.rb'
require_relative '../lib/music_importer.rb'
require_relative '../lib/music_library_controller.rb'

puts "Do you have a path? Y/N"
answer = gets.chomp
if answer == 'Y' or answer == 'y'
  puts "What is your path?"
  path = gets.chomp
  library = MusicLibraryController.new(path)
else
  library = MusicLibraryController.new
end

library.call
