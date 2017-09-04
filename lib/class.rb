class Song
  extend Concerns::Findable
  attr_accessor :name
  attr_reader :artist, :genre

  @@all = []

  def self.all
    @@all
  end

  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist = artist if artist.class == Artist
    self.genre = genre if genre.class == Genre
  end

  def save
    self.class.all << self
    self
  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end

  def genre=(genre)
    @genre = genre
    genre.add_song(self)
  end

  def self.new_from_filename(name)
    name = File.basename(name, ".mp3")
    artist_name=(name.split(" - ")[0])
    genre_name=(name.split(" - ")[2])
    song = Song.new(name.split(" - ")[1], Artist.find_or_create_by_name(artist_name), Genre.find_or_create_by_name(genre_name))
    song
  end

  def self.create_from_filename(name)
    song = self.new_from_filename(name)
    song.save
  end
end

class Artist
  extend Concerns::Findable
  attr_accessor :name, :songs

  @@all = []

  def self.all
    @@all
  end

  def initialize(name)
    @name = name
    @songs = []
  end

  def save
    self.class.all << self
    self
  end

  def add_song(song)
    return self if @songs.include?(song)
    @songs << song
    return self if song.artist != nil
    song.artist = self
  end

  def genres
    a = @songs.map { |e| e.genre }
    a.uniq
  end


end

class Genre
  extend Concerns::Findable
  attr_accessor :name, :songs

  @@all = []

  def self.all
    @@all
  end

  def initialize(name)
    @name = name
    @songs = []
  end

  def save
    self.class.all << self
    self
  end

  def add_song(song)
    return self if @songs.include?(song)
    @songs << song
    return self if song.genre != nil
    song.genre = self
  end

  def artists
    a = @songs.map { |e| e.artist }
    a.uniq
  end
end

class MusicImporter
  attr_accessor :path

  def initialize(path)
    @path = path
  end

  def import
    files.each do |f|
      Song.create_from_filename(f)
    end
  end

  def files
    Dir[@path+"/*.mp3"].map{ |f| File.basename f }
  end
end

class MusicLibraryController
  def initialize(path = './db/mp3s')
    music_importer = MusicImporter.new(path)
    music_importer.import
  end

  def call
    puts "Welcome to your music library!"

    path = ""
    until path == "exit"
      case path
      when "list songs"
        list_songs
      when "list artists"
        list_artists
      when "list genres"
        list_genres
      when "list artist"
        list_songs_by_artist
      when "list genre"
        list_songs_by_genre
      when "play song"
        play_song
      end
      puts "To list all of your songs, enter 'list songs'."
      puts "To list all of the artists in your library, enter 'list artists'."
      puts "To list all of the genres in your library, enter 'list genres'."
      puts "To list all of the songs by a particular artist, enter 'list artist'."
      puts "To list all of the songs of a particular genre, enter 'list genre'."
      puts "To play a song, enter 'play song'."
      puts "To quit, type 'exit'."
      puts "What would you like to do?"
      path = gets.strip
    end

  end

  def list_songs
    list = Song.all.sort {|a,b| a.name <=> b.name }
    i = 1
    list.each do |song|
      puts "#{i}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
      i += 1
    end
  end

  def list_artists
    list = Artist.all.sort {|a,b| a.name <=> b.name }
    i = 1
    list.each do |artist|
      puts "#{i}. #{artist.name}"
      i += 1
    end
  end

  def list_genres
    list = Genre.all.sort {|a,b| a.name <=> b.name }
    i = 1
    list.each do |genre|
      puts "#{i}. #{genre.name}"
      i += 1
    end
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    input = gets.strip
    if Artist.find_by_name(input)
      list = Artist.find_by_name(input).songs.sort {|a,b| a.name <=> b.name }
      i = 1
      list.each do |song|
        puts "#{i}. #{song.name} - #{song.genre.name}"
        i += 1
      end
    end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    input = gets.strip
    if Genre.find_by_name(input)
      list = Genre.find_by_name(input).songs.sort {|a,b| a.name <=> b.name }
      i = 1
      list.each do |song|
        puts "#{i}. #{song.artist.name} - #{song.name}"
        i += 1
      end
    end
  end

  def play_song
    puts "Which song number would you like to play?"
    list = Song.all.sort {|a,b| a.name <=> b.name }
    input = gets.strip.to_i
    if input > 0 && input <= list.size
      puts "Playing #{list[input-1].name} by #{list[input-1].artist.name}"
    end
  end

end
