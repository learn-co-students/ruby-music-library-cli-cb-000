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
        end
    end

    def split_list
        parsed_list = []
        @new_music.files.each {|file|
            parsed_list << file.split(" - ")}
        parsed_list
    end

    def list_songs
        alph_list = split_list.sort_by{|elem| elem[1]}
        alph_list.each_with_index {|song, index|
            puts "#{index + 1}. #{song.join(" - ")}" }
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
        new_list = split_list.collect{|elem| elem[0] == user_input}
        puts new_list
        if new_list.size != 0
            sorted_list = new_list.sort_by{|elem| elem[0]}
            puts sorted_list
            sorted_list.each_with_index { |e, i|
                puts "#{i+1}. #{e[0] - e[2]}"}
        end
    end

end
