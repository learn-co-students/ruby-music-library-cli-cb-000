class Genre
  extend Concerns::Findable
  include Concerns::Common::InstanceMethods
  extend Concerns::Common::ClassMethods
  attr_accessor :name
  attr_reader :songs

  @@all = []

  def initialize(name)
    super(name)
    @songs = []
  end

  def self.all
    @@all
  end

  # add song to the genre (has many), & genre to the song (belong to)
  def add_song(song)
    self.songs << song unless self.songs.include?(song)
    song.genre = genre unless song.genre == self
  end

  # genre has many unique artists through songs
  def artists
    self.songs.collect {|song| song.artist}.uniq
  end

  # Refactored to Common module

  # def self.destroy_all
  #   self.all.clear
  # end

  # def save
  #   self.class.all << self
  # end

  # def self.create(name)
  #   self.new(name).tap {|g| g.save}
  # end

end
