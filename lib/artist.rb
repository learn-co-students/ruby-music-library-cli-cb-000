class Artist
  extend Concerns::Findable

  attr_accessor :name, :songs

  @@all = []

  def initialize(name)
    self.name = name
    self.songs = []
  end


  def save
    @@all << self
  end


  def add_song(song)
    if !self.songs.include?(song)
      self.songs << song
    end

    if song.artist == nil
      song.artist = self
    end
  end

  def genres
    cuck = self.songs.collect {|song| song.genre}
    cuck.uniq {|genre| genre.name}
  end


#class methods
  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def self.create(name)
    self.new(name).tap do |f|
      f.save
    end
  end



end
