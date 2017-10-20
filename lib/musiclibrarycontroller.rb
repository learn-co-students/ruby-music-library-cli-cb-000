class MusicLibraryController
  def initialize(path='./db/mp3s')
    @path = path
    music_importer = MusicImporter.new(path)
    music_importer.import
  end

  def call
    loop do
      puts "Welcome to your music library!"
      puts "To list all of your songs, enter 'list songs'."
      puts "To list all of the artists in your library, enter 'list artists'."
      puts "To list all of the genres in your library, enter 'list genres'."
      puts "To list all of the songs by a particular artist, enter 'list artist'."
      puts "To list all of the songs of a particular genre, enter 'list genre'."
      puts "To play a song, enter 'play song'."
      puts "To quit, type 'exit'."
      puts "What would you like to do?"
      input = gets.chomp
      break if input == 'exit'
      case input
      when 'list songs' then self.list_songs
      when 'list artists' then self.list_artists
      when 'list genres' then self.list_genres
      when 'list artist' then self.list_songs_by_artist
      when 'list genre' then self.list_songs_by_genre
      when 'play song' then self.play_song
      end
    end
  end

  def list_songs
    Song.all.sort_by { |song| song.name }.each.with_index(1) do |song, ind|
      puts "#{ind}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    end
  end

  def list_artists
    Artist.all.sort_by { |artist| artist.name }.each.with_index(1) do |artist, ind|
      puts "#{ind}. #{artist.name}"
    end
  end

  def list_genres
    Genre.all.sort_by { |genre| genre.name }.each.with_index(1) do |genre, ind|
      puts "#{ind}. #{genre.name}"
    end
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    artist_name = gets.chomp
    artist = Artist.find_by_name(artist_name)
    if artist
      artist.songs.sort_by { |song| song.name }.each.with_index(1) do |song, ind|
        puts "#{ind}. #{song.name} - #{song.genre.name}"
      end
    end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    genre_name = gets.chomp
    genre = Genre.find_by_name(genre_name)
    if genre
      genre.songs.sort_by { |song| song.name }.each.with_index(1) do |song, ind|
        puts "#{ind}. #{song.artist.name} - #{song.name}"
      end
    end
  end

  def play_song
    puts "Which song number would you like to play?"
    song_num = gets.chomp.to_i
    lib_size = Song.all.size
    song = Song.all.sort_by { |song| song.name }[song_num - 1]
    if song_num.between?(1, lib_size) && song
      puts "Playing #{song.name} by #{song.artist.name}"
    end
  end


end
