require 'pry'
class MusicLibraryController

  attr_accessor :importer, :art_list
  # @list_songs = []

  def initialize(path = "./db/mp3s")
    @music_importer = MusicImporter.new(path)
    @music_importer.import
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
     loop do
         input = gets.chomp
         if input == "list songs"
           list_songs
         elsif input == "list artists"
           list_artists
         elsif input == "list genres"
           list_genres
         elsif input == "list artist"
           list_songs_by_artist
         elsif input == "list genre"
           list_songs_by_genre
         elsif input == "play song"
           play_song
         end
         break if input == "exit"
       end
     end

     def az_list
        name_list = []
        Song.all.each do |song|
          name_list << song.name
        end
        name_list.sort!
        @ascending_list = []
        name_list.each do |name|
          song = Song.find_by_name(name)
          @ascending_list << song
        end
      end

    def list_songs
      self.az_list
      counter = 0
      @ascending_list.each do |song|
        counter += 1
        puts "#{counter}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
      end
    end


    def list_artists
      art_list = []
      Artist.all.each do |artist|
        art_list << artist.name
      end
      art_list.sort!
      counter = 0
      art_list.each do |name|
        counter += 1
        puts "#{counter}. #{name}"
      end
    end

    def list_genres
      gen_list = []
      Genre.all.each do |genre|
        gen_list << genre.name
      end
      gen_list.sort!
      counter = 0
      gen_list.each do |name|
        counter += 1
        puts "#{counter}. #{name}"
      end
    end

    def list_songs_by_artist
      puts "Please enter the name of an artist:"
      input = gets.chomp
      artist = Artist.find_by_name(input)
      return if artist == nil
      songs = artist.songs
      name_list = []
      songs.each do |song|
        name_list << song.name
      end
      name_list.sort!
      i = 0
      name_list.each do |name|
        i+= 1
        song = Song.find_by_name(name)
        puts "#{i}. #{song.name} - #{song.genre.name}"
      end
    end

    def list_songs_by_genre
      puts "Please enter the name of a genre:"
      input = gets.chomp
      genre = Genre.find_by_name(input)
      return if genre == nil
      songs = genre.songs
      name_list = []
      songs.each do |song|
        name_list << song.name
      end
      name_list.sort!
      i = 0
      name_list.each do |name|
        i+= 1
        song = Song.find_by_name(name)
        puts "#{i}. #{song.artist.name} - #{song.name}"
      end
    end

    def play_song
      puts "Which song number would you like to play?"
      input = gets.chomp.to_i
      return if (input > Song.all.size || input < 1)
      self.az_list
      song_name = @ascending_list [input-1].name
      artist_name = @ascending_list [input-1].artist.name
      puts "Playing #{song_name} by #{artist_name}"
    end

end

# Teacher Solution
#
# class MusicLibraryController
#   def initialize(path = "./db/mp3s")
#     MusicImporter.new(path).import
#   end

  # def call
  #   input = ""
  #
  #   while input != "exit"
  #     puts "Welcome to your music library!"
  #     puts "To list all of your songs, enter 'list songs'."
  #     puts "To list all of the artists in your library, enter 'list artists'."
  #     puts "To list all of the genres in your library, enter 'list genres'."
  #     puts "To list all of the songs by a particular artist, enter 'list artist'."
  #     puts "To list all of the songs of a particular genre, enter 'list genre'."
  #     puts "To play a song, enter 'play song'."
  #     puts "To quit, type 'exit'."
  #     puts "What would you like to do?"

  #     input = gets.strip
  #
  #     case input
  #     when "list songs"
  #       list_songs
  #     when "list artists"
  #       list_artists
  #     when "list genres"
  #       list_genres
  #     when "list artist"
  #       list_songs_by_artist
  #     when "list genre"
  #       list_songs_by_genre
  #     when "play song"
  #       play_song
  #     end
  #   end
  # end
  #
  # def list_songs
  #   Song.all.sort{ |a, b| a.name <=> b.name }.each.with_index(1) do |s, i|
  #     puts "#{i}. #{s.artist.name} - #{s.name} - #{s.genre.name}"
  #   end
  # end
  #
  # def list_artists
  #   Artist.all.sort{ |a, b| a.name <=> b.name }.each.with_index(1) do |a, i|
  #     puts "#{i}. #{a.name}"
  #   end
  # end
  #
  # def list_genres
  #   Genre.all.sort{ |a, b| a.name <=> b.name }.each.with_index(1) do |g, i|
  #     puts "#{i}. #{g.name}"
  #   end
  # end
  #
  # def list_songs_by_artist
  #   puts "Please enter the name of an artist:"
  #   input = gets.strip
#
#     if artist = Artist.find_by_name(input)
#       artist.songs.sort{ |a, b| a.name <=> b.name }.each.with_index(1) do |s, i|
#         puts "#{i}. #{s.name} - #{s.genre.name}"
#       end
#     end
#   end
#
#   def list_songs_by_genre
#     puts "Please enter the name of a genre:"
#     input = gets.strip
#
#     if genre = Genre.find_by_name(input)
#       genre.songs.sort{ |a, b| a.name <=> b.name }.each.with_index(1) do |s, i|
#         puts "#{i}. #{s.artist.name} - #{s.name}"
#       end
#     end
#   end
#
#   def play_song
#     puts "Which song number would you like to play?"
#
#     input = gets.strip.to_i
#     if (1..Song.all.length).include?(input)
#       song = Song.all.sort{ |a, b| a.name <=> b.name }[input - 1]
#     end
#
#     puts "Playing #{song.name} by #{song.artist.name}" if song
#   end
# end
