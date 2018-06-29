require "pry"

class MusicLibraryController

    attr_accessor :path, :new_music

    def initialize(path="./db/mp3s")
        @path = path
        @new_music = MusicImporter.new(@path)
        @new_music.import
    end

    def call
        puts "Welcome to your music library!"
        user_input = ''

        while user_input != "exit"
            puts "To list all of your songs, enter 'list songs'."
            puts("To list all of the artists in your library, enter 'list artists'.")
            puts("To list all of the genres in your library, enter 'list genres'.")
            puts("To list all of the songs by a particular artist, enter 'list artist'.")
            puts("To list all of the songs of a particular genre, enter 'list genre'.")
            puts("To play a song, enter 'play song'.")
            puts("To quit, type 'exit'.")
            puts("What would you like to do?")
            user_input = gets
            execute_command(user_input)
        end
    end

    def execute_command(input)
        parse = input.split(" ")
        send(parse.join("_"))
    end

    def list_songs
        song_list = Song.all.sort_by{|song| song.name}
        song_list.each_with_index {|s,i|
        puts "#{i+1}. #{s.artist.name} - #{s.name} - #{s.genre.name}"}
    end

    def list_artists
        artist_list = Artist.all.sort_by{|elem| elem.name}
        artist_list.each_with_index {|a, i|
            puts "#{i+1}. #{a.name}"}
    end

    def list_genres
        genre_list = Genre.all.sort_by{|elem| elem.name}
        genre_list.each_with_index {|g,i|
            puts "#{i+1}. #{g.name}"}
    end

    def list_songs_by_artist
        puts "Please enter the name of an artist:"
        user_input = gets
        artist_list = Artist.find_by_name(user_input).songs
        if artist_list.size != 0
            sorted_list = artist_list.sort_by{|elem| elem.name}
            sorted_list.each_with_index{|e,i|
            puts "#{i+1}. #{e.name} - #{e.genre.name}"}
        end
    end

    def list_songs_by_genre
        puts "Please enter the name of a genre:"
        user_input = gets
        genre_list = Song.all.delete_if{|song| song.genre.name != user_input}
        if genre_list.size != 0
            sorted_list = genre_list.sort_by{|elem| elem.name}
            sorted_list.each_with_index{|e,i|
            puts "#{i+1}. #{e.artist.name} - #{e.name}"}
        end
    end

    def play_song
        song_list = Song.all.sort_by{|song| song.name}
        user_input = ''
        num_songs = (1..song_list.count)
        puts "Which song number would you like to play?"
        user_input = gets
        if num_songs.include?(user_input.to_i)
            song = song_list[(user_input.to_i) - 1]
            puts "Playing #{song.name} by #{song.artist.name}"
        end
    end

end
