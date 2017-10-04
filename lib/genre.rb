# class Genre
#   extend Concerns::Findable
#
#   attr_accessor :name, :songs
#
#   @@all = []
#
#   def initialize(name)
#     @name = name
#     @songs = []
#   end
#
#
#   def artists
#     artists = []
#     @songs.each do |song|
#       if !artists.include? song.artist
#         artists << song.artist
#       end
#     end
#     artists
#   end
#
#   def songs
#     @songs
#   end
#
#
#   def self.all
#     @@all
#   end
#
#
#   def self.destroy_all
#     @@all.clear
#   end
#
#
#   def save
#     @@all << self
#   end
#
#
#   def self.create(name)
#     genre = self.new(name)
#     genre.save
#     genre
#   end
#
# end




class Genre
  extend Concerns::Findable

  attr_accessor :name
  attr_reader :songs

  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end

  def self.all
    @@all
  end

  def self.destroy_all
    all.clear
  end

  def save
    self.class.all << self
  end

  def self.create(name)
    genre = new(name)
    genre.save
    genre

    # Or, as a one-liner:
    # new(name).tap{ |g| g.save }
  end

  def artists
    songs.collect{ |s| s.artist }.uniq
  end
end
