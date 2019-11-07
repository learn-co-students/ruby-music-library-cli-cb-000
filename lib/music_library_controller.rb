class MusicLibraryController
  attr_accessor

  def initialize(path='./db/mp3s')
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
    input = gets.strip.downcase
    if input == 'list songs'
      list_songs
    elsif input == 'list artists'
      list_artists
    elsif input == 'list genres'
      list_genres
    elsif input == 'list artist'
      list_songs_by_artist
    elsif input == 'list genre'
      list_songs_by_genre
    elsif input == 'play song'
      play_song
    elsif input == "exit"
      exit
    else
      "Invalid Entry. Try again."
    end
  end

  def list_songs
    Song.all.sort_by {|song| song.name}.each_with_index  do |song, i|
      puts "#{i + 1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    end
  end

  def list_artists
    Artist.all.sort_by {|artist| artist.name}.each_with_index do |artist, i|
      puts "#{i + 1}. #{artist.name}"
    end
  end

  def list_genres
    Genre.all.sort_by {|genre| genre.name}.each_with_index do |genre, i|
      puts "#{i + 1}. #{genre.name}"
    end
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    name = gets.strip
    artist = Artist.find_by_name(name)
    if artist
      artist.songs.sort_by {|song| song.name}.each_with_index do |song, i|
        puts "#{i + 1}. #{song.name} - #{song.genre.name}"
      end
    end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    name = gets.strip
    genre = Genre.find_by_name(name)
    if genre
      genre.songs.sort_by {|song| song.name}.each_with_index do |song, i|
        puts "#{i + 1}. #{song.artist.name} - #{song.name}"
      end
    end
  end

  def play_song
    puts "Which song number would you like to play?"
    num = gets.strip.to_i
    songs = Song.all.sort_by {|song| song.name}
    if num >= 1 && num <= Song.all.size
      puts "Playing #{songs[num - 1].name} by #{songs[num - 1].artist.name}"
    end
  end
end
