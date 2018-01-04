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

      when 'list artists'

      when 'list genres'

      when 'list artist'

      when 'list genre'

      when 'play song'

    end
    self.call if input != 'exit'

  end #-- .call  --

  def list_songs
    Song.all.sort.each do |song|
      puts "#{Song.all.index(song) + 1}. #{song.artist} - #{song.name} - #{song.genre}"
    end
  end

  def list_artists
    Artist.all.sort.each do |artist|
      puts "#{Artist.all.index(song) + 1}. #{artist.name}"
    end
  end

  def list_genres
    Genre.all.sort.each do |genre|
      puts "#{Genre.all.index(song) + 1}. #{genre.name}"
    end
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    artist_name = gets.strip
    return nil if find_by_name(artist_name) == nil
    artist = Artist.find_by_name(artist_name)
    artist.songs.each do |song|
      puts "#{artist.songs.index(song)}. #{song.name} - #{song.genre.name}"
    end
  end

  def list_songs_by_genre
    puts "Please enter the name of an artist:"
    genre_name = gets.strip
    return nil if find_by_name(artist_name) == nil
    genre = Genre.find_by_name(genre_name)
    genre.songs.each do |song|
      puts "#{genre.songs.index(song)}. #{song.name} - #{song.artist.name}"
    end
  end


end #-- MusicLibraryController  --
