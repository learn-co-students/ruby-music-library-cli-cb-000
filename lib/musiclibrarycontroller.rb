class MusicLibraryController

  def initialize(path = "./db/mp3s")
    MusicImporter.new(path).import
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
    while user_input = gets.strip
      case user_input
      when "list songs"
        self.list_songs
      when "list artists"
        self.list_artists
      when "list genres"
        self.list_genres
      when "list artist"
        self.list_songs_by_artist
      when "list genre"
        self.list_songs_by_genre
      when "play song"
        self.play_song
      when "exit"
        break
      end
    end
  end

  def list_songs
    Song.all.sort{|a, b| a.name <=> b.name}.each.with_index{|song, i| puts "#{i+1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"}
  end

  def list_artists
    Artist.all.collect{|artist| artist.name}.uniq.sort.each.with_index{|name, i| puts "#{i+1}. #{name}" }
  end

  def list_genres
    Genre.all.collect{|genre| genre.name}.uniq.sort.each.with_index{|name, i| puts "#{i+1}. #{name}" }
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    artist_name = gets.strip
    Song.all.select{|song| song.artist.name == artist_name}.sort{|a, b| a.name <=> b.name}.each.with_index{|song, i| puts "#{i+1}. #{song.name} - #{song.genre.name}"}
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    genre_name = gets.strip
    Song.all.select{|song| song.genre.name == genre_name}.sort{|a, b| a.name <=> b.name}.each.with_index{|song, i| puts "#{i+1}. #{song.artist.name} - #{song.name}"}
  end

  def play_song
    puts "Which song number would you like to play?"
    song_number = gets.strip.to_i
    if song_number > 0 && song_number <= Song.all.size
      song = Song.all.sort{|a, b| a.name <=> b.name}[song_number-1]
      puts "Playing #{song.name} by #{song.artist.name}"
    end
  end
end
