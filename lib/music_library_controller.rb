require 'pry'
class MusicLibraryController

  extend Concerns::Findable

  def initialize(path="./db/mp3s")
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
    puts "What would you like to do?"
    input = gets.chomp

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
    end


    until input == "exit"
      input = gets
    end
  end

  def list_songs
    #sorted = Song.all.sort{|s1,s2| s1.name <=> s2.name}
    Song.sorted.each_with_index{|song, index| puts "#{index+1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"}
  end

  def list_artists
    Artist.sorted.each_with_index{|artist, index| puts "#{index+1}. #{artist.name}"}
  end

  def list_genres
    Genre.sorted.each_with_index{|genre, index| puts "#{index+1}. #{genre.name}"}
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    input = gets.chomp
    artist = Artist.find_by_name(input)
    artist.songs.sort{|s1,s2| s1.name <=> s2.name}.each_with_index {|song, index| puts "#{index+1}. #{song.name} - #{song.genre.name}"} if !artist.nil?
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    input = gets.chomp
    genre = Genre.find_by_name(input)
    genre.songs.sort{|s1,s2| s1.name <=> s2.name}.each_with_index {|song, index| puts "#{index+1}. #{song.artist.name} - #{song.name}"} if !genre.nil?
  end

  def play_song
    puts "Which song number would you like to play?"
    input = gets.chomp
    song = Song.sorted[input.to_i-1] if input.to_i.between?(1,5)
    puts "Playing #{song.name} by #{song.artist.name}" if !song.nil?
  end

end
