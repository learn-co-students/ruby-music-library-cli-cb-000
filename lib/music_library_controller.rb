class MusicLibraryController

  # It initializes with an optional path to the music, but defaulting to ./db/mp3s. It creates a MusicImporter and imports the music.
  # Has a #call method that starts the CLI and asks the user for input. Check out the tests for specifics.

  def initialize(path = "./db/mp3s") #sets default argument to mp3 folder
    importer = MusicImporter.new(path) #creates a new MusicImporter instance using "path" as the argument
    importer.import
    #apply music_importer's #import method to var importer, an instance of MusicImporter
  end

  def call
    input = ""
    #create a blank var string placeholder for storing input
    while input != "exit"
      #while input is not equal to "exit"
      puts "Welcome to Your Music Library!"
      #welcome user to his/her library
      puts "What would you like to do? You may list songs, list artists, list genres, list artist, list genre, or play song"
      #then ask what they wanna do
      input = gets.strip
      #gets doesn't remove any white space. The chomp method removes whitespace AFTER the user input. And the strip method removes whitespace BEFORE and AFTER the user input.
      case input
        when "list songs"
          songs
        when "list artists"
          artists
        when "list genres"
          genres
        when "list artist"
          list_artist
        when "list genre"
          list_genre
        when "play song"
          play_song
      end
    end
  end

  def artists
    Artist.all.each.with_index(1) do |artist, index|
    #Class Artist, array @@all, innumerator each, #with_index(start at 1). This allows outputting as a numbered list in the console.
      puts "#{index}. #{artist}"
    end
  end

  def genres
    Genre.all.each.with_index(1) do |g, i|
      puts "#{i}. #{g}"
    end
  end

  def list_artist
    puts "What is the artist's name (case sensitive) that you'd like to list songs for?"
    # puts "What artist by name you like to list songs for?"
    artist_input = gets.strip
    if artist = Artist.find_by_name(artist_input)
      artist.songs.each.with_index(1) do |s, i|
        puts "#{i}. #{s}"
      end
    end
  end

  def list_genre
    puts "Name the genre you like to list songs for?"
    genre_input = gets.strip
    genre = Genre.find_by_name(genre_input)
      if genre # == true
        genre.songs.each.with_index(1) do |song, index|
          puts "#{index}. #{song}"
        end
      end
  end

  def play_song
    puts "What song number would you like to play?"
    song_input = gets.strip
    puts "Playing #{Song.all[song_input.to_i-1]}"
  end

  def songs
    Song.all.each.with_index(1) do |s, i|
      puts "#{i}. #{s}"
    end
  end

end
