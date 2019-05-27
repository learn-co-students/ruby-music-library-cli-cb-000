class MusicLibraryController

  def initialize(path = "./db/mp3s")
    MusicImporter.new(path).import
  end

  def call

    input = ""
    while input != "exit"
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
        when "list songs"
          list_songs
        when "list artists"
          list_artists
        when "list genres"
          list_genres
        when "list artist"
          list_songs_by_artist
        when "list genre"
          list_songs_by_genre
        when "play song"
          play_song
      end #-- case --
    end #-- while --
  end #-- call --

  def list_songs
    sorted_songs = Song.all.sort_by { |song| song.name}
    sorted_songs.each { |song|
      puts "#{sorted_songs.index(song) + 1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    }
  end

  def list_artists
    sorted_artists = Artist.all.sort_by { |artist| artist.name}
    sorted_artists.each { |artist|
      puts "#{sorted_artists.index(artist) + 1}. #{artist.name}"}
  end

  def list_genres
    sorted_genres = Genre.all.sort_by { |genre| genre.name}
    sorted_genres.each { |genre|
      puts "#{sorted_genres.index(genre) + 1}. #{genre.name}" }
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    artist_name = gets.strip
    if (artist = Artist.find_by_name(artist_name)) != nil
      sorted_songs =  artist.songs.sort_by { |song| song.name}
      sorted_songs.each { |song|
        puts "#{sorted_songs.index(song) + 1}. #{song.name} - #{song.genre.name}"
      }
    end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    genre_name = gets.strip
    if (genre = Genre.find_by_name(genre_name)) != nil
      sorted_songs =  genre.songs.sort_by { |song| song.name}
      sorted_songs.each { |song|
        puts "#{sorted_songs.index(song) + 1}. #{song.artist.name} - #{song.name}"
      }
    end
  end

  def play_song
    puts "Which song number would you like to play?"
    sorted_songs = Song.all.sort_by { |song| song.name}
    input = gets.strip.to_i
    if sorted_songs.detect { |song| sorted_songs.index(song) == input - 1} != nil
      song_selected = sorted_songs.detect { |song| sorted_songs.index(song) == input - 1}
      puts "Playing #{song_selected.name} by #{song_selected.artist.name}"
    end
  end

end #-- MusicLibraryController --
