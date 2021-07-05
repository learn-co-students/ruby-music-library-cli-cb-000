class MusicLibraryController

  def initialize(file_path="./db/mp3s")
    MusicImporter.new(file_path).import
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
    exited = false
    while !exited
      puts "What would you like to do?"
      case gets.chomp
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
      when "exit"
        exited = true
      end
    end
  end

  def list_songs
    Song.list_songs
  end

  def list_artists
    Artist.list_artists
  end

  def list_genres
    Genre.list_genres
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    artist_name = gets.chomp
    if Artist.find_by_name(artist_name)
      artist = Artist.find_by_name(artist_name)
      artist.list_songs_by_artist
    end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    genre_name = gets.chomp
    if Genre.find_by_name(genre_name)
      genre = Genre.find_by_name(genre_name)
      genre.list_songs_by_genre
    end
  end

  def play_song
    puts "Which song number would you like to play?"
    song_number = gets.chomp
    if song_number.to_i.between?(1, Song.all.length)
      song = Song.play_song(song_number)
      puts "Playing #{song.name} by #{song.artist.name}"
    end
  end
end
