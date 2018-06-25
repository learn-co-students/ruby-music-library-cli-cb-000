class MusicLibraryController
  attr_accessor :path

  def initialize(path = "./db/mp3s")
    importer = MusicImporter.new(path)
    importer.import
  end

  def call
    user_input = ''
    while user_input != "exit"
      puts "Welcome to your music library!"
      puts "To list all of your songs, enter 'list songs'."
      puts "To list all of the artists in your library, enter 'list artists'."
      puts "To list all of the genres in your library, enter 'list genres'."
      puts "To list all of the songs by a particular artist, enter 'list artist'."
      puts "To list all of the songs of a particular genre, enter 'list genre'."
      puts "To play a song, enter 'play song'."
      puts "To quit, type 'exit'."
      puts "What would you like to do?"
      user_input = gets.strip
        if user_input == "list songs"
          self.list_songs
        elsif user_input == "list artists"
          self.list_artists
        elsif user_input == "list genres"
          self.list_genres
        elsif user_input == "list artist"
          self.list_songs_by_artist
        elsif user_input == "list genre"
          self.list_songs_by_genre
        elsif user_input == "play song"
          self.play_song
        end
    end
  end

  def list_songs
    Song.all.sort_by{|a| a.name}.each.with_index(1) do |songs, i|
      puts "#{i}. #{songs.artist.name} - #{songs.name} - #{songs.genre.name}"
    end
  end

  def list_artists
    Artist.all.sort_by{|a| a.name}.each.with_index(1) do |artist, i|
      puts "#{i}. #{artist.name}"
    end
  end

  def list_genres
    Genre.all.sort_by{|a| a.name}.each.with_index(1) do |genre, i|
      puts "#{i}. #{genre.name}"
    end
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    input = gets.chomp
    if artist = Artist.find_by_name(input)
      artist.songs.sort_by{|a| a.name}.each.with_index(1) do |song, i|
        puts "#{i}. #{song.name} - #{song.genre.name}"
      end
    end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    input = gets.chomp
    if genre = Genre.find_by_name(input)
      genre.songs.sort_by{|a| a.name}.each.with_index(1) do |song, i|
        puts "#{i}. #{song.artist.name} - #{song.name}"
      end
    end
  end

  def play_song
    puts "Which song number would you like to play?"
    input = gets.chomp.to_i
    if input < Song.all.length && input > 0
      song = Song.all.sort_by!{|s|s.name}
      puts "Playing #{song[input - 1].name} by #{song[input -1].artist.name}"
    end
  end

end
