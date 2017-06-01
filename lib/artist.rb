require_relative './concerns/findable'
require_relative './concerns/nameable_saveable'

class Artist < Concerns::NameableSaveable
    extend Concerns::Findable::ClassMethods

  attr_reader :songs

  def initialize(name)
    super(name)
    @songs = Array.new
  end

  def add_song(song)
    song.artist = self if (song.artist == nil || song.artist.name != self.name)
    @songs << song if @songs.detect{|next_song| next_song.name == song.name} == nil
  end

  def genres()
    songs.collect{|song| song.genre}.uniq
  end
end
