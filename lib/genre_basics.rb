class Genre

  attr_accessor :name, :songs

  @@genres = []

  extend Concerns::Findable

  def initialize(genre)
    @name = genre
    @songs = []
  end

  def self.all
    @@genres
  end

  def save
    self.class.all << self
  end

  def self.destroy_all
    self.all.clear
  end

  def self.create(name)
    genre = self.new(name)
    genre.save
    genre
  end

  def artists
      self.songs.uniq {|e| e.artist.name}.map {|i| i.artist}
  end

  def self.print_genres
    arr= []
    self.all.uniq {|e| arr << "#{e.name}"}
    arr.sort
  end

end
