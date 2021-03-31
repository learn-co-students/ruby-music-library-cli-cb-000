require 'fileutils'

class MusicLibraryController

    attr_accessor :musicImporter

    def initialize(path="./db/mp3s")
        @musicImporter = MusicImporter.new(path)
        @musicImporter.import
    end

    def natashasCall
        user_input = ""
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
            user_input = gets.strip
            if user_input == "list songs"
            self.list_songs
            elsif user_input == "list artists"
            self.list_artists
            elsif user_input == "list genres"
            self.list_genres
            elsif user_input == "list artist"
            self.list_songs_by_artist
            elsif user_input == "list genre"
            self.list_songs_by_genre
            elsif user_input == "play song"
            self.play_song
            end #if
        end #while
    end #call

    def call
        user_input = ""
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
            #In rake console, must use STDIN.gets
            #user_input = STDIN.gets.chomp.to_s
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
               # else
                #    puts ("Unknown input:  #{user_input}")
                #    puts("Please try again...")
            end #case
        end #while
    end #call

    def list_songs
        #spec expects:
        #"1. Thundercat - For Love I Come - dance"
        #musicImporter.files.each { |x| puts("#{i}. #{x.gsub(".mp3", "")}\n"); i=i+1}
        songsArr = Song.all.sort_by{ |s| s.name}
        i = 1
        songsArr.each{ |s| puts("#{i}. #{s.artist.name} - #{s.name} - #{s.genre.name}"); i += 1}
        songsArr
    end

    def list_artists
      Artist.ordered_list_sort
      nil
    end

    def list_genres
      Genre.ordered_list_sort
      nil
    end

    def list_songs_by_artist
            #use print in real life so you don't have the newline
            puts("Please enter the name of an artist:")
            #user_input = STDIN.gets.chomp.to_s
            user_input = gets.strip
            if (user_input != "")
                artistObj = Artist.find_by_name(user_input)
                if (artistObj)
                    sortedSongs = artistObj.songs.sort_by{ |s| s.name}
                    i = 1
                    #print the songs in an ordered list
                    sortedSongs.each{ |s|  puts("#{i}. #{s.name} - #{s.genre.name}"); i+=1}
                end
            end
    end

    def list_songs_by_genre
        #use print in real life so you don't have the newline
        puts("Please enter the name of a genre:")
        #user_input = STDIN.gets.chomp.to_s
        user_input = gets.chomp
        if (user_input)
            genreObj = Genre.find_by_name(user_input)
            if (genreObj)
                i = 1
                sortedSongs = genreObj.songs.sort_by { |s| s.name }
                sortedSongs.each { |s| puts("#{i}. #{s.artist.name} - #{s.name}"); i+= 1 }
            end
        end
    end

    def list_songs
        #spec expects:
        #"1. Thundercat - For Love I Come - dance"
        #musicImporter.files.each { |x| puts("#{i}. #{x.gsub(".mp3", "")}\n"); i=i+1}
        songsArr = Song.all.sort_by{ |s| s.name}
        i = 1
        songsArr.each{ |s| puts("#{i}. #{s.artist.name} - #{s.name} - #{s.genre.name}"); i += 1}
        songsArr
    end

    def play_song
      #use print in real life so you don't have the newline
      #I don't like how I did this as sortedSongArr may not match
      #list_songs, if list_songs changes.
      sortedSongArr = Song.all.sort_by{|s| s.name}
      #user_input = STDIN.gets.chomp.to_i
      puts("Which song number would you like to play?")
      user_input = gets.chomp.to_i
      if (user_input > 0 && user_input <= sortedSongArr.size)
        i = user_input - 1 #adjust for array index
        puts("Playing #{sortedSongArr[i].name} by #{sortedSongArr[i].artist.name}")
      end  #if
    end #play_song
end #class
