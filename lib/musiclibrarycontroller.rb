class MusicLibraryController
  require 'pry'

  def initialize(path = './db/mp3s')
    @songs = MusicImporter.new(path).import
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
    input = ""
    until input == 'exit' do
      puts "What would you like to do?"
      input = gets.chomp
      case input
        when 'list songs'then list_songs
        when 'list artists' then list_artists
        when 'list genres' then list_genres
        when 'list artist' then list_songs_by_artist
        when 'list genre' then list_songs_by_genre
        when 'play song' then play_song
      end
    end



    input
  end

  def list_songs
    sorted_song_list = @songs.sort_by {|song| song.split(" - ")[1]}

    sorted_song_list.each_with_index do |song,index|
      song_name = song.split(" - ")[1]
      artist = song.split(" - ")[0]
      genre = song.split(" - ")[2][0..-5]
      puts "#{index+1}. #{artist} - #{song_name} - #{genre}"
    end

  end

  def list_artists
    sorted_artist_list = Artist.all.map {|artist| artist.name}.sort.uniq
    sorted_artist_list.each_with_index {|artist,index| puts "#{index+1}. #{artist}"}
  end

  def list_genres
    sorted_genre_list = Genre.all.map {|genre| genre.name}.sort.uniq
    sorted_genre_list.each_with_index {|genre,index| puts "#{index+1}. #{genre}"}
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    artist_name = gets.chomp
    artist = Artist.find_by_name(artist_name)
    if artist
      sorted_songs = artist.songs.sort_by {|song| song.name}
      sorted_songs.each_with_index {|song, index| puts "#{index+1}. #{song.name} - #{song.genre.name}"}
    end

  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    genre_name = gets.chomp
    genre = Genre.find_by_name(genre_name)
    if genre
      sorted_songs = genre.songs.sort_by {|song| song.name}
      sorted_songs.each_with_index {|song, index| puts "#{index+1}. #{song.artist.name} - #{song.name}"}
    end
  end

  def play_song
    songs = @songs.sort_by {|song| song.split(" - ")[1]}

    puts "Which song number would you like to play?"
    song_number = gets.chomp.to_i

    if song_number.between?(1,songs.length)
      song = songs[song_number-1].split(" - ")[1]
      artist = songs[song_number-1].split(" - ")[0]
      puts "Playing #{song} by #{artist}"
    end

  end



end
