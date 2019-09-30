class MusicLibraryController
 attr_accessor :musicimporter

  def initialize(path='./db/mp3s')
    @musicimporter = MusicImporter.new(path)
    @musicimporter.import
  end


  def call
    input = " "
    while input != "exit" do
    puts "Welcome to your music library!"
    puts "To list all of your songs, enter 'list songs'."
    puts "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the genres in your library, enter 'list genres'."
    puts "To list all of the songs by a particular artist, enter 'list artist'."
    puts "To list all of the songs of a particular genre, enter 'list genre'."
    puts "To play a song, enter 'play song'."
    puts "To quit, type 'exit'."
    puts "What would you like to do?"
    input = gets.chomp
      if input == "list songs"
          self.list_songs
        elsif input == "list artists"
          self.list_artists
        elsif input == "list genres"
          self.list_genres
        elsif input == "list artist"
          self.list_songs_by_artist
        elsif input == "list genre"
          self.list_songs_by_genre
        elsif input == "play song"
        self.play_song
      end
    end
  end

  def list_songs
    list = Song.all.sort_by {|song| song.name}
    list.each_with_index {|s,i| puts "#{i+1}. #{s.artist.name} - #{s.name} - #{s.genre.name}"}
  end

  def list_artists
    list = Artist.all.sort_by {|artist| artist.name}
    list.each_with_index {|a,i| puts "#{i+1}. #{a.name}"}
  end


  def list_genres
    list = Genre.all.sort_by {|genre| genre.name}
    list.each_with_index {|g,i| puts "#{i+1}. #{g.name}"}
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    selection = gets.chomp
    artist = Artist.all.find {|artist| artist.name == selection}
       if artist
       sorted = artist.songs.sort_by {|song| song.name }
       sorted.each_with_index {|s,i| puts "#{i+1}. #{s.name} - #{s.genre.name}"}
    end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    selection = gets.chomp
    genre = Genre.all.find {|genre| genre.name == selection}
       if genre
       sorted = genre.songs.sort_by {|genre| genre.name }
       sorted.each_with_index {|g,i| puts "#{i+1}. #{g.artist.name} - #{g.name}"}
    end
  end

  def play_song
    puts "Which song number would you like to play?"
    selection = gets.chomp.to_i
    songs = Song.all.sort_by {|song| song.name}
    if selection > 0 && selection <= songs.length
    puts "Playing #{songs[selection-1].name} by #{songs[selection-1].artist.name}"
    end
  end





end
