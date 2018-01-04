
class MusicLibraryController

  def initialize(path = './db/mp3s')
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

    input = gets.strip
    case input
      when 'list songs'
        self.list_songs
      when 'list artists'
        self.list_artists
      when 'list genres'
        self.list_genres
      when 'list artist'
        self.list_songs_by_artist
      when 'list genre'
        self.list_songs_by_genre
      when 'play song'
        self.play_song
    end
    self.call if input != 'exit'

  end #-- .call  --

  def list_songs
    sorted_songs = Song.all.sort_by {|song| song.name}
    sorted_songs.each do |song|
      puts "#{sorted_songs.index(song) + 1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    end
    return "Success"
  end

  def list_artists
    sorted_artists = Artist.all.sort_by {|artist| artist.name}
    sorted_artists.each do |artist|
      puts "#{sorted_artists.index(artist) + 1}. #{artist.name}"
    end
    return "Success"
  end

  def list_genres
    sorted_genres = Genre.all.sort_by {|genre| genre.name}
    sorted_genres.each do |genre|
      puts "#{sorted_genres.index(genre) + 1}. #{genre.name}"
    end
    return "Success"
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    artist_name = gets.strip
    return nil if Artist.find_by_name(artist_name) == nil
    artist = Artist.find_by_name(artist_name)
    sorted_songs = artist.songs.sort_by {|song| song.name}
    sorted_songs.each do |song|
      puts "#{sorted_songs.index(song) + 1}. #{song.name} - #{song.genre.name}"
    end
    return "Success"
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    genre_name = gets.strip
    return nil if Genre.find_by_name(genre_name) == nil
    genre = Genre.find_by_name(genre_name)
    sorted_genres = genre.songs.sort_by {|song| song.name}
    sorted_genres.each do |song|
      puts "#{sorted_genres.index(song) + 1}. #{song.artist.name} - #{song.name}"
    end
    return "Success"
  end

  def play_song
    puts "Which song number would you like to play?"
    sorted_songs = Song.all.sort_by {|song| song.name}
    i = gets.strip.to_i
    song = sorted_songs.detect {|song| sorted_songs.index(song) == i - 1}
    return nil if i < 1 || i > sorted_songs.size
    puts "Playing #{song.name} by #{song.artist.name}"
  end



end #-- MusicLibraryController  --
