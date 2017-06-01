require_relative './concerns/findable'
require_relative './concerns/nameable_saveable'

class Genre < Concerns::NameableSaveable
  extend Concerns::Findable::ClassMethods

  attr_reader :songs

  def initialize(name)
    super(name)
    @songs = Array.new
  end

  def add_song(song)
    song.genre = self if (song.genre == nil || song.genre.name != self.name)
    @songs << song if @songs.detect{|next_song| next_song.name == song.name} == nil
  end

  def artists()
    songs.collect{|song| song.artist}.uniq
  end
end
