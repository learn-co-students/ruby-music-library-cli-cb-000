class MusicLibraryController
  attr_accessor :path

  def initialize(path = './db/mp3s')
    self.path = path
    @music_importer = MusicImporter.new(self.path)
    @music_importer.import
  end

  def call
    loop do
      puts 'Welcome to your music library!'
      puts "To list all of your songs, enter 'list songs'."
      puts "To list all of the artists in your library, enter 'list artists'."
      puts "To list all of the genres in your library, enter 'list genres'."
      puts "To list all of the songs by a particular artist, enter 'list artist'."
      puts "To list all of the songs of a particular genre, enter 'list genre'."
      puts "To play a song, enter 'play song'."
      puts "To quit, type 'exit'."
      puts "What would you like to do?"
      operation = gets
      
      break if operation == 'exit'
      
      case operation
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

  def list_songs
    Song.all.sort.each_with_index do |song, idx|
      puts "#{idx + 1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    end
  end

  def list_artists
    Artist.all.sort.each_with_index do |artist, idx|
      puts "#{idx + 1}. #{artist.name}"
    end
  end

  def list_genres
    Genre.all.sort.each_with_index do |genre, idx|
      puts "#{idx + 1}. #{genre.name}"
    end
  end

  def list_songs_by_artist
    puts 'Please enter the name of an artist:'
    artist_name = gets

    Song.all.select do |song|
      song.artist.name == artist_name
    end.sort.each_with_index do |song, idx|
      puts "#{idx + 1}. #{song.name} - #{song.genre.name}"
    end
  end

  def list_songs_by_genre
    puts 'Please enter the name of a genre:'
    genre_name = gets

    Song.all.select do |song|
      song.genre.name == genre_name
    end.sort.each_with_index do |song, idx|
      puts "#{idx + 1}. #{song.artist.name} - #{song.name}"
    end
  end

  def play_song
    puts 'Which song number would you like to play?'
    song_number = gets

    return if song_number.to_i < 1 || song_number.to_i > Song.all.length

    song = Song.all.sort[song_number.to_i - 1]
    puts "Playing #{song.name} by #{song.artist.name}" unless song.nil?
  end
end
