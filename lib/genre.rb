class Genre
      extend Concerns::Findable
  attr_accessor :name, :song
  @@all = []
  def initialize(name)
    @name = name
    @songs = []
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def save
    @@all << self
  end

  def self.create(new_genre)
    new_genre = self.new(new_genre)
    new_genre.save
    new_genre
  end

  def songs
    @songs
  end

  def add_song(song)
    song.genre = self
    self.songs << song

  end

  def self.find(name)
    self.all.find {|object| object.name == name}
  end

  def self.find_or_create_by_name(name)
    if self.find_by_name(name)
      self.find_by_name(name)
    else
      name = self.new(name)
      name.save
      name
    end
  end

  def artists
    @songs.collect do |song|
      song.artist
    end.uniq
  end


end
