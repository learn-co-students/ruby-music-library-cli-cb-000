require_relative './concerns/findable'
require_relative './concerns/nameable_saveable'
require_relative './music_importer'

class Song < Concerns::NameableSaveable
  extend Concerns::Findable::ClassMethods

  class << self  # establishes a block for defining class methods and fields!
    def new_from_filename(file)
      return MusicImporter.import_file(file) # all file management encapsulated in MusicImporter
    end

    def create_from_filename(file)
      return self.new_from_filename(file).save
    end
  end

  attr_accessor :artist, :genre

  def initialize(name, artist = nil, genre = nil)
    super(name)
    self.artist = artist unless artist == nil
    self.genre = genre unless genre == nil
  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end

  def genre=(genre)
    @genre = genre
    genre.add_song(self)
  end
end
