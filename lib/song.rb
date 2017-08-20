class Song

  attr_accessor :name
  attr_reader :artist, :genre

  @@all = []

  def self.all
    @@all
  end

  def initialize(name, artist = nil, genre = nil)
    @name = name
    if artist.nil?
      @artist = nil
    else
      self.artist = artist
    end
    self.genre = genre
  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end

  def genre=(genre)
    return unless genre.is_a?(Genre)
    @genre = genre
    genre.songs << self unless find_song(self, genre)
  end

  def save
    @@all << self
  end

  def self.create(name)
    song = Song.new(name)
    song.save
    song
  end

  def self.destroy_all
    @@all.clear
  end

  def find_song(song, genre)
    genre.songs.find { |existing_song| existing_song.name == song.name }
  end

  def self.find_by_name(name)
    @@all.find(&:name)
  end

  def self.find_or_create_by_name(name)
    return if name.nil?
    puts "NAME: #{name}"
    existing_song = find_by_name(name)
    return if existing_song.nil?
    puts existing_song.inspect
    if name != existing_song.name
      return Song.create(name)
    else
      return existing_song
    end
  end
end