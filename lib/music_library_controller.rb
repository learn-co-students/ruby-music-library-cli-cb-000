require 'pry'

class MusicLibraryController
  attr_accessor :path

  def initialize(path='./db/mp3s')
    @path = path
    MusicImporter.new(@path).import
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
    input = gets.chomp
    accepted_input = ["list songs", "list artists", "list genres", "list artist", "list genre", "play song", "exit"]

    unless accepted_input.include?(input)
      call
    end
    selection(input)
  end

  def list_songs
    sort_song.each_with_index do |song,idx|
      puts "#{idx+1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    end
  end

  def list_artists
    Artist.all.sort{|x,y| x.name <=> y.name}.each_with_index do |artist,idx|
      puts "#{idx+1}. #{artist.name}"
    end
  end

  def list_genres
    Genre.all.sort{|x,y| x.name <=> y.name}.each_with_index do |genre,idx|
      puts "#{idx+1}. #{genre.name}"
    end
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    input = gets.chomp
    songs = Song.all.select { |song| song.artist.name == input }
    # if songs == []
    #   lists_songs_by_artist
    # end
    #
    songs.sort{|x,y| x.name <=> y.name}.each_with_index do
      |song,idx| puts "#{idx + 1}. #{song.name} - #{song.genre.name}"
    end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    input = gets.chomp
    songs = Song.all.select { |song| song.genre.name == input }

    songs.sort{|x,y| x.name <=> y.name}.each_with_index do
      |song,idx| puts "#{idx + 1}. #{song.artist.name} - #{song.name}"
    end
  end

  def play_song
    puts "Which song number would you like to play?"
    input = gets.chomp

    sort_song.each_with_index do |song,idx|
      puts "Playing #{song.name} by #{song.artist.name}" if input.to_i == (idx + 1)
    end
  end

  def sort_song
    Song.all.sort! { |x,y| x.name <=> y.name }
  end

  def selection(input)
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
    when "exit"
      exit
    end
  end
end
# binding.pry
