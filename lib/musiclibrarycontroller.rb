class MusicLibraryController

  def initialize(path='./db/mp3s')
    controller = MusicImporter.new(path)
    controller.import
  end

  def call
    command = ""
    puts "Welcome to your music library!"
    puts "To list all of your songs, enter 'list songs'."
    puts "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the genres in your library, enter 'list genres'."
    puts "To list all of the songs by a particular artist, enter 'list artist'."
    puts "To list all of the songs of a particular genre, enter 'list genre'."
    puts "To play a song, enter 'play song'."
    puts "To quit, type 'exit'."
    while command != 'exit' do
      puts "What would you like to do?"
      command = gets.strip
      case command
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

  def alphabetize(collection)

  end

  def list_songs
    Song.all.sort.each_with_index.collect do |song, i|
      puts "#{i + 1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
      song
    end
  end

  def list_artists
    Artist.all.sort.each_with_index.collect do |artist, i|
      puts "#{i + 1}. #{artist.name}"
      artist
    end
  end

  def list_genres
    Genre.all.sort.each_with_index.collect do |genre, i|
      puts "#{i + 1}. #{genre.name}"
      genre
    end
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    artist = Artist.find_by_name(gets.strip)
    if artist
      artist.songs.sort.each_with_index.collect do |song, i|
        puts "#{i + 1}. #{song.name} - #{song.genre.name}"
        song
      end
    end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    genre = Genre.find_by_name(gets.strip)
    if genre
      genre.songs.sort.each_with_index.collect do |song, i|
        puts "#{i + 1}. #{song.artist.name} - #{song.name}"
        song
      end
    end
  end

  def play_song
    puts "Which song number would you like to play?"
    songs = Song.all.sort
    choice = gets.strip.to_i - 1
    puts "Playing #{songs[choice].name} by #{songs[choice].artist.name}" unless choice + 1 > songs.size || choice < 1
  end

end
