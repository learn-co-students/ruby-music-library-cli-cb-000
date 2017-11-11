require "pry"
class MusicLibraryController
  attr_accessor :path

  def initialize(path)
    @path = path
    new_music_importer = MusicImporter.new(path)
    #binding.pry
    new_music_importer.import
  end

  def call
    user_input = 0
      while user_input != "exit"
        puts "Welcome to your music library!"
        puts "To list all of your songs, enter 'list songs'."
        puts "To list all of the artists in your library, enter 'list artists'."
        puts "To list all of the genres in your library, enter 'list genres'."
        puts "To list all of the songs by a particular artist, enter 'list artist'."
        puts "To list all of the songs of a particular genre, enter 'list genre'."
        puts "To play a song, enter 'play song'."
        puts "To quit, type 'exit'."
        puts "What would you like to do?"
        user_input = gets.chomp
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
    files = Dir.entries(@path)
    #binding.pry
    files.delete(".")
    files.delete("..")
    files.collect do |file|
      file.slice! ".mp3"
    end
    files = files.sort_by { |item| item.split(" - ")[1] }
    counter = 1
    files.each do |file|
      puts "#{counter}. #{file}"
      counter = counter + 1
    end
  end

  def list_artists
    files = Dir.entries(@path)
    #binding.pry
    files.delete(".")
    files.delete("..")
    files.collect do |file|
      file.slice! ".mp3"
    end
    files = files.sort_by { |item| item.split(" - ")[0] }
    #binding.pry
    counter = 1
    comparer = ""
    files = files.uniq
    files.each do |file|
      #binding.pry
      file = file.split(" - ")
      #binding.pry
      next if file[0] == comparer
      comparer = file[0]
      puts "#{counter}. #{file[0]}"
      counter = counter + 1
    end
  end

  def list_genres
    files = Dir.entries(@path)
    #binding.pry
    files.delete(".")
    files.delete("..")
    files.collect do |file|
      file.slice! ".mp3"
    end
    files = files.sort_by { |item| item.split(" - ")[2] }
    #binding.pry
    counter = 1
    comparer = ""
    files = files.uniq
    files.each do |file|
      #binding.pry
      file = file.split(" - ")
      #binding.pry
      next if file[2] == comparer
      comparer = file[2]
      puts "#{counter}. #{file[2]}"
      counter = counter + 1
    end
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    artist = gets.chomp
    files = Dir.entries(@path)
    #binding.pry
    files.delete(".")
    files.delete("..")
    files.collect do |file|
      file.slice! ".mp3"
    end
    #binding.pry
    counter = 1
    files.each do |a|
      a = a.split(" - ")
      if artist == a[0]
        puts "#{counter}. #{a[1]} - #{a[2]}"
        counter = counter + 1
        #binding.pry
      end
    end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    genre = gets.chomp
    files = Dir.entries(@path)
    #binding.pry
    files.delete(".")
    files.delete("..")
    files.collect do |file|
      file.slice! ".mp3"
    end
    #binding.pry
    counter = 1
    #binding.pry
    files.each do |a|
      a = a.split(" - ")
      if genre == a[2]
        puts "#{counter}. #{a[0]} - #{a[1]}"
        counter = counter + 1
      end
    end
  end

  def play_song
    puts "Which song number would you like to play?"
    user_choice = gets.chomp

    files = Dir.entries(@path)
    #binding.pry
    files.delete(".")
    files.delete("..")
    files.collect do |file|
      file.slice! ".mp3"
    end
    files = files.sort_by { |item| item.split(" - ")[1] }
    #binding.pry
    output = "Playing Larry Csonka by Action Bronson"
    #binding.pry
    counter_counter = 1
    counter_for_appending = "#{counter_counter}"
    files = files.each do |file|
      file = file + counter_for_appending
      counter_counter = counter_counter + 1
      #binding.pry
    end
    files.each do |song|
      if song.include?(user_choice)
      song = song.split(" - ")
      #binding.pry
        #binding.pry
        output = "Playing #{song[1]} by #{song[0]}"
      end
    end
    puts output
  end
end
