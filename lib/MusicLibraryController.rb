class MusicLibraryController

  attr_reader :music_importer
  # @list_songs = []

  def initialize(path = "./db/mp3s")
    @music_importer = MusicImporter.new(path)
    @music_importer.import
  end

  def call
     puts "Welcome to your music library!"
     puts "To list all of your songs, enter 'list songs'."
     puts "To list all of the artists in your library, enter 'list artists'."
     puts "To list all of the genres in your library, enter 'list genres'."
     puts "To list all of the songs by a particular artist, enter 'list artist'."
     puts "To list all of the songs of a particular genre, enter 'list genre'."
     puts "To play a song, enter 'play song'."
     puts "To quit, type 'exit'."
     puts "What would you like to do?"
     loop do
         input = gets.chomp
         if input == "list songs"
           list_songs
         elsif input == "list artists"
           list_artists
         elsif input == "list genres"
           list_genres
         elsif input == "list artist"
           list_songs_by_artist
         elsif input == "list genre"
           list_songs_by_genre
         elsif input == "play song"
           play_song
         end
         break if input == "exit"
       end
     end



end
