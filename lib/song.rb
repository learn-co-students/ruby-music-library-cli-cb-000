class Song
  extend Basics::ClassMethods
  extend Concerns::Findable
  include Basics::InstanceMethods

  attr_accessor :name
  attr_reader :artist, :genre

  @@all = []

  def initialize (name, artist=nil, genre=nil)
    @name = name
    if artist != nil
      artist.add_song(self)
    end
    if genre != nil
      genre.add_song(self)
    end
    @@all << self
  end


  def self.all
    @@all
  end

  def artist=(artist)
#    @artist = artist
#    c=1
#    puts "artist.songs: #{artist.songs}"
#    until artist.songs.include?(self) || c == 4
#      puts "pre c:#{c}"
#      artist.add_song(self)
#      puts "post artist.songs: #{artist.songs}"
#      puts "post c:#{c}"
#      c+=1
#    end
    if @artist != artist
      @artist = artist
    end
    if artist.songs.include?(self) == false
      artist.add_song(self)
    end
  end

  def genre=(genre)
    if @genre != genre
      @genre = genre
    end
    if genre.songs.include?(self) == false
      genre.add_song(self)
    end
  end

  def self.new_from_filename(filename)
    artist = filename.split(' - ')[0]
    song = filename.split(' - ')[1]
    genre = filename.split(' - ')[2].split('.')[0]
    self.new(song,Artist.find_or_create_by_name(artist),Genre.find_or_create_by_name(genre))
  end


  def self.create_from_filename(filename)
    artist = filename.split(' - ')[0]
    song = filename.split(' - ')[1]
    genre = filename.split(' - ')[2].split('.')[0]
    if self.find_by_name(song) == nil
      self.new(song,Artist.find_or_create_by_name(artist),Genre.find_or_create_by_name(genre))
    end
#    s.artist=Artist.find_or_create_by_name(artist)
#    s.genre=Genre.find_or_create_by_name(genre)
  end

end
