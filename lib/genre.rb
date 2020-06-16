class Genre

  extend Concerns::Findable

  attr_accessor :name, :songs
  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end

  def artists
    artists = []
    self.songs.each do |hees|
      artists << hees.artist unless artists.include? hees.artist
    end
    return artists
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

  def self.create(genre)
    created_genre = self.new(genre)
    created_genre.save
    created_genre
  end

end

# Teacher solution
#
# class Genre
#   extend Concerns::Findable
#
#   attr_accessor :name
#   attr_reader :songs
#
#   @@all = []
#
#   def initialize(name)
#     @name = name
#     @songs = []
#   end
#
#   def self.all
#     @@all
#   end
#
#   def self.destroy_all
#     all.clear
#   end
#
#   def save
#     self.class.all << self
#   end
#
#   def self.create(name)
#     genre = new(name)
#     genre.save
#     genre
#
#     # Or, as a one-liner:
#     # new(name).tap{ |g| g.save }
#   end
#
#   def artists
#     songs.collect{ |s| s.artist }.uniq
#   end
# end
