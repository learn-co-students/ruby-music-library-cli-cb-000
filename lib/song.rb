class Song

  @@all = []

  attr_accessor :name

  def initialize(name, artist=nil, genre=nil)
    @name = name
    self.artist = artist if artist
    self.genre = genre if genre
  end

  def save
    @@all << self
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all = []
  end

  def self.create(name, artist=nil, genre=nil)
    song = Song.new(name, artist=nil, genre=nil)
    song.save
    song
  end

  def artist
    @artist
  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end

  def genre
    @genre
  end

  def genre=(genre)
    @genre = genre
    @genre.songs << self if @genre.songs.none? {|s| s == self}
  end

  def self.find_by_name(name)
    @@all.detect {|song| song.name == name}
  end

  def self.find_or_create_by_name(name)
    if !find_by_name(name)
      create(name)
    else
      find_by_name(name)
    end
  end

  def self.new_from_filename(filename)
    file = filename.delete_suffix!(".mp3").split(' - ').map {|word| word.strip}
    artist = file[0]
    song = file[1]
    genre = file[2]
    Song.new(song, Artist.find_or_create_by_name(artist), Genre.find_or_create_by_name(genre))
  end

  def self.create_from_filename(filename)
    song = new_from_filename(filename)
    song.save
  end

  def self.list_songs
    i = 1
    all.sort_by(&:name).each do |song|
      puts "#{i}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
      i += 1
    end
  end

  def self.play_song(song_number)
    all.sort_by(&:name)[song_number.to_i - 1]
  end
end
