require "pry"
require "concerns/findable"

class Artist
  extend Concerns::Findable

  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end

  attr_accessor :name, :songs

  def self.all
    @@all
  end

  def save
    self.class.all << self
  end

  def self.create(name)
      self.all << self.new(name)
      self.all.last
  end

    def self.find_by_name(name)
    self.all[name] if name = self.all.find_index { |s| s.name == name }
  end

#  def self.find_or_create_by_name(name)
#    self.find_by_name(name) || self.create(name)
#  end
#
#  def self.new_from_filename(file)
#    info = file.match(/(.*) - (.*)\.mp3/)
#    s = new_by_name(info[2])
#    s.artist_name = info[1]
#    #binding.pry
#    s
#  end
#
#  def self.create_from_filename(file)
#    info = file.match(/(.*) - (.*)\.mp3/)
#    s = create_by_name(info[2])
#    s.artist_name = info[1]
#    #binding.pry
#    s
#  end

  def self.destroy_all
     self.all.clear
  end

  def add_song(song)
    @songs << song unless @songs.include?(song)
    song.artist = self unless song.artist
  end

  def genres
    @songs.collect {|s| s.genre}.uniq
  end


end
