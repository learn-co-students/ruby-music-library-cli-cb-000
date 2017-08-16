class MusicLibraryController
  attr_reader :music, :filenames

  def initialize(path = "./db/mp3s")
    @music = MusicImporter.new(path)
    @filenames = @music.import
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
    input = gets.chomp
    send(input.sub(" ", "_"))
    call until input == "exit"
  end

  def list_songs
    i = 1
    @filenames.sort_by { |filename| filename.split(" - ")[1] }.each do |filename|
      filename.slice!(".mp3")
      puts "#{i}. #{filename}"
      i += 1
    end
  end

  def list_artists
    i = 1
    artists = []
    Artist.all.each {|artist| artists << artist.name }
    artists.sort.uniq.each do |artist|
      puts "#{i}. #{artist}"
      i += 1
    end
  end

  def list_genres
    i = 1
    genres = []
    Genre.all.each {|genre| genres << genre.name }
    genres.sort.uniq.each do |genre|
      puts "#{i}. #{genre}"
      i += 1
    end
  end

  def list_artist
    list_songs_by_artist
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    artist_name = gets.chomp
    if Artist.find_by_name(artist_name)
      i = 1
      artist = Artist.find_by_name(artist_name)
      artist.songs.sort_by{|song|song.name}.each do |song|
        puts "#{i}. #{song.name} - #{song.genre.name}"
        i += 1
      end
    end
  end

  def list_genre
    list_songs_by_genre
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    genre_name = gets.chomp
    if Genre.find_by_name(genre_name)
      i = 1
      genre = Genre.find_by_name(genre_name)
      genre.songs.sort_by{|song|song.name}.each do |song|
        puts "#{i}. #{song.artist.name} - #{song.name}"
        i += 1
      end
    end
  end

  # def play_song
  #   puts "Which song number would you like to play?"
  #   selection = gets
  #   @filenames.sort_by { |filename| filename.split(" - ")[1] }.each do |song_name|
  #     song_name = song_name.split(" - ")[1]
  #     binding.pry
  #     if song_name.start_with?(selection)
  #       song = Song.find_by_name(song_name.split(". ")[1])
  #       puts "Playing #{song} by #{song.artist}"
  #     end
  #   end
  # end

  def play_song
    puts "Which song number would you like to play?"
    selection = gets
    if (selection.to_i != 0) && (selection.to_i - 1 < @filenames.size)
      selection = selection.to_i - 1
      sorted_files = @filenames.sort_by { |filename| filename.split(" - ")[1] }
      song = sorted_files[selection].split(" - ")[1]
      puts "Playing #{song} by #{Song.find_by_name(song).artist.name}"
    end
  end

end
