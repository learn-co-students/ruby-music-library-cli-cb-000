class MusicLibraryController

  attr_accessor :path, :importer

  def initialize(path = './db/mp3s')
    @path = path
    @importer = MusicImporter.new(path)
    importer.import

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

    input = gets.strip
    if input == "exit"
      return "exit"
    else
      call
    end

    if input == "list songs"
      list_songs
    end

    if input == 'list artists'
      list_artists
    end

    if input == 'list genres'
      list_genres
    end

    if input == 'list artist'
      list_songs_by_artist
    end

    if input == 'list genre'
      list_songs_by_genre
    end

    if input == 'play song'
      play_song
    end

  end


  def list_songs
    songs = Song.all.sort_by(&:name)
    songs.each_with_index {|song, index| puts "#{index+1}. #{song.artist.name} - #{song.name} - #{song.genre.name}" }


  end

  def list_artists
    artists = Artist.all.sort_by(&:name)
    artists.each_with_index{|artist, index| puts "#{index+1}. #{artist.name}"}
  end

  def list_genres
    genres = Genre.all.sort_by(&:name)
    genres.each_with_index{|genre, index| puts "#{index+1}. #{genre.name}"}
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    input = gets.strip
      if artist = Artist.find_by_name(input)
        artist.songs.sort_by(&:name).each_with_index{|song, index| puts "#{index+1}. #{song.name} - #{song.genre.name}"}
      end

  end


  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    input = gets.strip
      if genre = Genre.find_by_name(input)
        genre.songs.sort_by(&:name).each_with_index{|song, index| puts "#{index+1}. #{song.artist.name} - #{song.name}"}
      end

  end

  def play_song
      puts "Which song number would you like to play?"
        input = gets.strip.to_i
          if input <= Song.all.length
            songs = Song.all.sort_by(&:name)
              songs.select.with_index do |song, index|
                if index == input-1
                  puts "Playing #{song.name} by #{song.artist.name}"

          end
        end
      end

  end


end
