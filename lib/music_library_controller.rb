class MusicLibraryController
    attr_accessor :path
    attr_reader :imported

    def initialize(path = "./db/mp3s")
        @path = path
        @imported = MusicImporter.new(path).import
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
        
        input = nil
        while input != "exit"
            input = gets.strip
            
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
        end
    end

    def list_songs
        number = 1
        @song_array = []
        Song.all.sort_by {|song| song.name}.each do |song|
            puts "#{number}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
            number += 1
        end 
    end

    def list_artists
        number = 1
        Artist.all.sort_by {|artist| artist.name}.each do |artist|
            puts "#{number}. #{artist.name}"
            number += 1
        end
    end

    def list_genres
        number = 1
        Genre.all.sort_by {|genre| genre.name}.each do |genre|
            puts "#{number}. #{genre.name}"
            number += 1
        end
    end

    def list_songs_by_artist
        puts "Please enter the name of an artist:"
        artist_to_search = gets.strip
        artist_info = Artist.all.detect {|artist| artist.name == artist_to_search}

        unless !artist_info
        artist_songs = artist_info.songs
        
        number = 1
        artist_songs.sort_by {|song| song.name}.each do |song|
            puts "#{number}. #{song.name} - #{song.genre.name}"
            number += 1
        end
        end
    end

    def list_songs_by_genre
        puts "Please enter the name of a genre:"
        genre_to_search = gets.strip
        genre_info = Genre.all.detect {|genre| genre.name == genre_to_search}

        unless !genre_info
            genre_songs = genre_info.songs

            number = 1
            genre_songs.sort_by {|song| song.name}.each do |song|
                puts "#{number}. #{song.artist.name} - #{song.name}"
                number += 1
            end
        end
    end

    def play_song
        puts "Which song number would you like to play?"
        song_number = gets.strip.to_i

        songs = Song.all.sort_by {|song| song.name}

        if song_number != 0 && song_number <= songs.size
            song = songs[song_number - 1]
            puts "Playing #{song.name} by #{song.artist.name}"
        end
    end
end
# Upon initialization, the CLI should accept an optional path to the library of MP3 files, defaulting to ./db/mp3s/. It should then instantiate a MusicImporter object, which it will use to import songs from the specified library.
# Add a #call method that starts the CLI and prompts the user for input. Read the tests carefully for specifics.