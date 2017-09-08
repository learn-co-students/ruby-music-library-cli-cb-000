require 'pry'

class MusicLibraryController

  attr_accessor :path

  def initialize(path = './db/mp3s')
    self.path = path
    MusicImporter.new(path).import
  end

  def call
    user_input = ""
    while user_input != 'exit'
      puts "Welcome to your music library!"
      puts "To list all of your songs, enter 'list songs'."
      puts "To list all of the artists in your library, enter 'list artists'."
      puts "To list all of the genres in your library, enter 'list genres'."
      puts "To list all of the songs by a particular artist, enter 'list artist'."
      puts "To list all of the songs of a particular genre, enter 'list genre'."
      puts "To play a song, enter 'play song'."
      puts "To quit, type 'exit'."
      puts "What would you like to do?"
      user_input = gets.strip
      case user_input
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
    end
  end

  def list_songs
    i = 1
    Song.all.sort_by! {|song| song.name}
    Song.all.each do |song|
      puts "#{i}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
      i += 1
    end
  end

  def list_artists
    i = 1
    Artist.all.sort_by! {|artist| artist.name}
    Artist.all.each do |artist|
      puts "#{i}. #{artist.name}"
      i += 1
    end
  end

  def list_genres
    i = 1
    Genre.all.sort_by! {|genre| genre.name}
    Genre.all.each do |genre|
      puts "#{i}. #{genre.name}"
      i += 1
    end
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    i = 1
    user_input = gets.strip
    searched_artist = Artist.find_by_name(user_input)
    if searched_artist != nil
      searched_artist.songs.sort_by! {|song| song.name}
      searched_artist.songs.each do |song|
        puts "#{i}. #{song.name} - #{song.genre.name}"
        i += 1
      end
    end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    i = 1
    user_input = gets.strip
    searched_genre = Genre.find_by_name(user_input)
    if searched_genre != nil
      searched_genre.songs.sort_by! {|song| song.name}
      searched_genre.songs.each do |song|
        puts "#{i}. #{song.artist.name} - #{song.name}"
        i += 1
      end
    end
  end

  def play_song
    puts "Which song number would you like to play?"
    user_input = gets.strip.to_i
    Song.all.sort_by! {|song| song.name}
    Song.all.each_with_index do |song, index|
      if user_input == index + 1
        puts "Playing #{Song.all[index].name} by #{Song.all[index].artist.name}"
      end
    end
  end
end
