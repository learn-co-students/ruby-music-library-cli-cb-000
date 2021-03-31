class Song
  extend Concerns::Findable
  attr_accessor :name , :artist, :genre
  @@all = []
  def self.all
    @@all
  end
  def self.destroy_all
    @@all = []
  end
  def save
    @@all << self
  end

  def self.create(name)
    song = self.new(name)
    song.save
    song
  end
  def genre=(arg)
    if arg.class == String
      temp = Genre.find_or_create_by_name(arg)
      @genre = temp
      temp.songs << self
    else
      @genre = arg
      arg.songs << self
      arg.songs = arg.songs.uniq
    end
  end
  def artist=(arg)
    if arg.class == String
      temp = Artist.find_or_create_by_name(arg)
      @artist = temp
      temp.add_song(self)
    else
      @artist = arg
      arg.add_song(self)
      arg.songs = arg.songs.uniq
    end
  end
  def initialize(name, artist=nil, genre=nil)
    @name = name
    if artist != nil
      self.artist = artist
      #@artist = artist
    end
    if genre != nil
      #@genre = genre
      self.genre = genre
    end
  end
  def self.new_from_filename(filename)
    fileshort = filename[0..-5]
    ray = fileshort.split(" - ")
    track = self.new(ray[1], ray[0], ray[2])
    track
  end
  def self.create_from_filename(filename)
    done = self.new_from_filename(filename)
    done.save
    done
  end
end
