

class Artist
  extend Concerns::Findable
  include Concerns::Savable::InstanceMethods
  extend Concerns::Savable::ClassMethods

  attr_accessor :name, :songs

  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end

  def self.all
    @@all
  end

  def self.create(name)
    new(name).tap{|o| o.save}
  end
  # Tap description: 'new(name)' makes and object with itself. Tap's pipe represents the object and delivers it to the block, in this case 'o.save' calls the save instance method. Finally, tap's pipe 'o' returns itself. This is useful for when the block is long with many methods. It allows the reader to know upfront the fundamental functionality: object generation and return with a block in between.
  # Alternate syntax:
  # def self.create(name)
  #   obj = new(name)
  #   obj.save
  #   obj
  # end

  def genres
    self.songs.map do |s|
      s.genre
    end.uniq
    # #uniq returns a new array by removing duplicate values in self.
  end

  def add_song(song)
    if song.artist != self
      song.artist = self
    end
    # song.artist = self unless song.artist == self
    @songs << song unless @songs.include?(song)
    #push song to @songs unless @songs already includes the song
  end

  def to_s
    self.name
  end

#   # binding.pry
end

# learn ./spec/002_artist_basics_spec.rb
