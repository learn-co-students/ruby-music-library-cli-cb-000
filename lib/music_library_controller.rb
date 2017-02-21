class MusicLibraryController

  def initialize(path = './db/mp3s')
    music_importer = MusicImporter.new(path)
    music_importer.import
  end

  def call
    input = ""

    while input != "exit" do
      puts "Welcome to Your Music Library"
      puts "What can I help you with?"
      input = gets.chomp

      case input
      when "list songs"
        list_songs
      when "list artists"
        list_artists
      when "list genres"
        list_genres
      when "play song"
        play_song
      when "list artist"
        list_artist_songs
      when "list genre"
        list_genre_songs
      end
    end

  end

  def list_songs
    Song.all.each_with_index do |song, index|
      puts "#{index + 1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    end
  end

  def list_artists
    Artist.all.each do |artist|
      puts artist.name
    end
  end

  def list_genres
    Genre.all.each do |genre|
      puts genre.name
    end
  end

  def play_song
    puts "Please enter the number of the song you want to play:"
    i = gets.chomp.to_i - 1
    song = Song.all[i]
    puts "Playing #{song.artist.name} - #{song.name} - #{song.genre.name}"
  end

  def list_artist_songs
    puts "Please enter the artist:"
    artist = gets.chomp

    Artist.find_by_name(artist).songs.each do |song|
      puts "#{song.artist.name} - #{song.name} - #{song.genre.name}"
    end
  end

  def list_genre_songs
    puts "Please enter the genre:"
    genre = gets.chomp

    Genre.find_by_name(genre).songs.each do |song|
      puts "#{song.artist.name} - #{song.name} - #{song.genre.name}"
    end
  end

end