class Genre

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

  def self.all
    @@all
  end

  def self.create(name)
    new_genre = Genre.new(name)
    new_genre.save
    new_genre
  end

  def add_song(song)
    if !@songs.include?(song)
      @songs << song
      song.genre = self
    end
  end

  def artists
    @songs.collect{|s|s.artist}.uniq
  end

  def self.list_genre(genre_name)
    genre = self.find_by_name(genre_name)
    genre.songs.each{|song| puts "#{song.artist.name} - #{song.name} - #{song.genre.name}"}
  end

  def self.print_all
    self.all.each {|g| puts g.name}
  end


end