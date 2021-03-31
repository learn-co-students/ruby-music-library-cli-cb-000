require 'pry'

class Song
  extend Concerns::Findable
  extend Memorable::ClassMethods
  include Memorable::InstanceMethods

  attr_accessor :name
  attr_reader :artist, :genre
  @@all = []

  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist = artist if artist
    self.genre = genre if genre
  end

  def self.all
    @@all
  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end

  def genre=(genre)
    @genre = genre
    @genre.songs << self if !@genre.songs.any? {|x| x == self}
  end

  def self.new_from_filename(filename)
    part = file_parser(filename)

    genre = Genre.find_or_create_by_name(part[:genre])
    artist = Artist.find_or_create_by_name(part[:artist])
    song = Song.new(part[:song],artist,genre)
  end

  def self.create_from_filename(filename)
    song = new_from_filename(filename)
    self.all << song
    song
  end

  def self.file_parser(filename)
    part = filename.chomp(".mp3").split(" - ")
    {song: part[1], artist: part[0], genre: part[2]}
  end

  def self.print_all_with_index
    self.all.each.with_index {|s,i| puts "#{i+1}. #{printable(s)}"}
  end

  def self.printable(song)
    "#{song.artist.name} - #{song.name} - #{song.genre.name}"
  end


end
