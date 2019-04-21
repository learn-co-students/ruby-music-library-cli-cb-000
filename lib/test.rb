require 'bundler'
Bundler.require

module Concerns
end

require_all 'lib'

# mlc = MusicLibraryController.new
# mlc.play_song

# mlc = MusicLibraryController.new
# mlc.list_genres

# mi = MusicImporter.new("./db/mp3s")
# puts mi.import

# song_variable = Song.new_from_filename("Thundercat - For Love I Come - dance.mp3")
# puts song_variable
# puts "song_variable.name returns #{song_variable.name}"
# puts "song_variable.artist.name returns #{song_variable.artist.name}"
# puts "song_variable.genre.name returns #{song_variable.genre.name}"

      # expect(song.name).to eq("For Love I Come")
      # expect(song.artist.name).to eq("Thundercat")
      # expect(song.genre.name).to eq("dance")
