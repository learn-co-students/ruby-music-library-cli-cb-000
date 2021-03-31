require_relative 'concerns/concerns.rb'

class Genre

  @@all = []
  extend Concerns::Findable
  attr_accessor :name, :songs

  def initialize(name)
    @name = name
    @songs = []
  end

  def artists
    artists_array = []
    Song.all.each do |song_variable|
      puts "song_variable.artist currently reads #{song_variable.artist}"
      if song_variable.artist != nil && artists_array != []
        unique = true
        artists_array.each do |existing_artist|
          if existing_artist == song_variable.artist
            unique = false
          end
        end
        if unique == true
          artists_array << song_variable.artist
        end
      elsif song_variable.artist != nil && artists_array == []
        artists_array << song_variable.artist
      end
    end
    artists_array
  end

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
    new_genre_variable = Genre.new(name)
    new_genre_variable.save
    new_genre_variable
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
    song_variable.access_genre_variable = self
  end

end
