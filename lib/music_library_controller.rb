class MusicLibraryController
  attr_accessor :path
  attr_reader :lib


  def initialize(path="./db/mp3s")
    @path = path
    MusicImporter.new(path).import
  end

  def list_songs
    all_songs = Song.all
    all_songs.sort_by! {|x| x.name}
    all_songs.each.with_index(1) do |song, index|
      puts "#{index}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    end
  end

  def list_artists
    artist_list = []
    Artist.all.each do |s|
      artist_list << s.name
    end

    artist_list.sort.each.with_index(1) do |artist, index|
      puts "#{index}. #{artist}"
    end
  end

  def list_genres
    genre_list = []
    Genre.all.each do |s|
      genre_list << s.name
    end

    genre_list.sort.each.with_index(1) do |genre, index|
      puts "#{index}. #{genre}"
    end
  end

  def list_songs_by_artist
    artist_songs = []
    puts "Please enter the name of an artist:"
    artist = gets.strip
    artist = artist.downcase
    Artist.all.each do |x|
      if x.name.downcase == artist
        artist_songs = x.songs
        artist_songs.sort_by! {|y| y.name}
        artist_songs.each.with_index(1) do |song, index|
          puts "#{index}. #{song.name} - #{song.genre.name}"
        end
      end
    end

  end

  def list_songs_by_genre
    genre_songs = []
    puts "Please enter the name of a genre:"
    genre = gets.strip
    genre = genre.downcase
    Genre.all.each do |x|
      if x.name.downcase == genre
        genre_songs = x.songs
        genre_songs.sort_by! {|y| y.name}
        genre_songs.each.with_index(1) do |song, index|
          puts "#{index}. #{song.artist.name} - #{song.name}"
        end
      end
    end
  end

  def play_song
    puts "Which song number would you like to play?"
    song = gets.strip.to_i
    all_songs = Song.all
    all_songs.sort_by! {|x| x.name}
    if song <= Song.all.length && song > 0
      puts "Playing #{all_songs[song-1].name} by #{all_songs[song-1].artist.name}"
    end

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
      call = gets.strip
      call = call.downcase
      if call =="exit"
        break
      elsif call == "list songs"
        self.list_songs
      elsif call == "list artists"
        self.list_artists
      elsif call == "list genres"
        self.list_genres
      elsif call == "list artist"
        self.list_songs_by_artist
      elsif call == "list genre"
        self.list_songs_by_genre
      elsif call == "play song"
        self.play_song
      end #close If Statement
    end #close Loop
  end #close def call

end#close MusicLibraryController Class
