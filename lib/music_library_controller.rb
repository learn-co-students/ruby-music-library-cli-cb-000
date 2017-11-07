require "pry"
class MusicLibraryController
  def initialize(path="./db/mp3s")
    @path = path
    @importer = MusicImporter.new(path)
    @importer.import
  end

  attr_accessor :path

  def call
    input = ""
    puts "Welcome to your music library!"
    until input == "exit"
      puts "To list all of your songs, enter 'list songs'."
      puts "To list all of the artists in your library, enter 'list artists'."
      puts "To list all of the genres in your library, enter 'list genres'."
      puts "To list all of the songs by a particular artist, enter 'list artist'."
      puts "To list all of the songs of a particular genre, enter 'list genre'."
      puts "To play a song, enter 'play song'."
      puts "To quit, type 'exit'."
      puts "What would you like to do?"
      input = gets
      case input
      when 'list songs'
        list_songs
      when 'list artists'
        list_artists
      when 'list genres'
        list_genres
      when 'list artist'
        list_songs_by_artist
      when 'list genre'
        list_songs_by_genre
      when 'play song'
        play_song
      end
    end
  end

  def list_songs #Lists numbered and alphabetized by song name
    i = 0
    Song.all.sort {|a,b| a.name <=> b.name}.each {|s| i+=1; puts "#{i}. #{s.artist.name} - #{s.name} - #{s.genre.name}"}
  end

  def list_artists #Lists numbered and alphabetized by song name
    i = 0
    Artist.all.sort {|a,b| a.name <=> b.name}.each {|s| i+=1; puts "#{i}. #{s.name}"}
  end

  def list_genres #Lists numbered and alphabetized by song name
    i = 0
    Genre.all.sort {|a,b| a.name <=> b.name}.each {|s| i+=1; puts "#{i}. #{s.name}"}
  end

  def list_songs_by_artist #Lists numbered and alphabetized by song name
    i = 0
    puts "Please enter the name of an artist:"
    artist_name = gets
    if (Artist.find_by_name(artist_name) != nil)
      Artist.find_by_name(artist_name).songs.sort {|a,b| a.name <=> b.name}.each {|s| i+=1; puts "#{i}. #{s.name} - #{s.genre.name}"}
    end
  end

  def list_songs_by_genre #Lists numbered and alphabetized by song name
    i = 0
    puts "Please enter the name of a genre:"
    genre_name = gets
    if (Genre.find_by_name(genre_name) != nil)
      Genre.find_by_name(genre_name).songs.sort {|a,b| a.name <=> b.name}.each {|s| i+=1; puts "#{i}. #{s.artist.name} - #{s.name}"}
    end
  end

  def play_song
    puts "Which song number would you like to play?"
    num = gets.to_i - 1   #Converts user input into Song.all index for song.
    song = Song.all.sort {|a,b| a.name <=> b.name}[num]
    puts "Playing #{song.name} by #{song.artist.name}" if num < Song.all.length && num >= 0
  end
end
