class Artist

  extend Concerns::Findable
  attr_accessor :name, :songs
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

  def self.all?
    @@all
  end

  def self.create(name)
    new_artist = Artist.new(name)
    new_artist.save
    new_artist
  end

  def add_song(song)
    if !@songs.include?(song)
      @songs << song
      song.artist = self
    end
  end

  def genres
    @songs.collect{|s|s.genre}.uniq
  end

  def self.list_artist(artist_name)
    artist = self.find_by_name(artist_name)
    artist.songs.each{|song| puts "#{song.artist.name} - #{song.name} - #{song.genre.name}"}
  end

  def self.print_all
    self.all.each {|a| puts a.name}
  end


end