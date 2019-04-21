require_relative 'concerns/concerns.rb'

class Artist

  extend Concerns::Findable
  @@all = []
  attr_accessor :name

  def initialize(name)
    @name = name
    @songs = []
  end

  def self.all
    @@all
  end

  def save
    @@all << self
  end

  def self.destroy_all
    @@all = []
  end

  def self.create(name)
    new_artist_variable = Artist.new(name)
    new_artist_variable.save
    new_artist_variable
  end

  def add_song(song_variable)
    not_yet_included = true
    self.songs.each do |existing_song|
      if existing_song == song_variable
        not_yet_included = false
      end
    end
    if not_yet_included == true
      self.songs << song_variable
    end
    song_variable.access_artist_variable = self
  end


  def genres
    genres_array = []
    Song.all.each do |song_variable|
      if song_variable.genre != nil && genres_array != []
        unique = true
        genres_array.each do |existing_genre|
          if song_variable.genre == existing_genre
            unique = false
          end
        end
        if unique == true
          genres_array << song_variable.genre
        end
      elsif song_variable.genre != nil && genres_array == []
        genres_array << song_variable.genre
      end
    end
    genres_array
  end

  def songs
    @songs
  end

end
