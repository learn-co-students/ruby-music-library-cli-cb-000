require 'bundler'
Bundler.require

module Concerns
  @@all = []
  module Findable


    def find_by_name(name)

      self.all.find { |x| x.name == name }

    end

    def find_or_create_by_name(name)
      if   self.all.find { |x| x.name == name } == nil
        new_item = self.new(name)
        self.all << new_item
        self.all.find { |x| x.name == name }
      else
        self.all.find { |x| x.name == name }
      end

    end

  end
  def all
    @@all

  end


  def destroy_all
    @@all = []
  end


end

require_all 'lib'

class Song
extend Concerns
extend Concerns::Findable

attr_reader :artist, :genre

attr_accessor :name
  def initialize(name, artist = nil, genre = nil)
    @name = name
    @genre = genre
    @artist = artist
    artist.songs << self if artist != nil
    genre.songs << self if genre != nil

  end

  def self.new_from_filename(filename)
    fnarray = filename.split(" - ")
    name = fnarray[1]
    artist = fnarray[0]
    genre = fnarray[2].split(".")[0]
    song = Song.find_or_create_by_name(name)
    song.artist = Artist.find_or_create_by_name(artist)
    song.genre = Genre.find_or_create_by_name(genre)
    song


  end

  def self.create_from_filename(filename)
    fnarray = filename.split(" - ")
    name = fnarray[1]
    artist = fnarray[0]
    genre = fnarray[2].split(".")[0]
    song = Song.find_or_create_by_name(name)
    song.artist = Artist.find_or_create_by_name(artist)
    song.genre = Genre.find_or_create_by_name(genre)
    song


  end

  def self.create(name, artist = nil, genre= nil)
    new_song = Song.new(name, artist, genre)
    new_song.save
    new_song
  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end

  def genre=(genre)
    @genre = genre
    genre.songs << self if genre.songs.include?(self) == false
  end

  def save
    Song.all << self
  end

  def self.all1

    all = Song.all.select { |x| x.class == Song }

    all
  end




end

class Artist

extend Concerns
extend Concerns::Findable

attr_accessor :name, :songs
  def initialize(name)
    @name = name
    @songs = []

  end

  def self.create(name)
    new_artist = Artist.new(name)
    new_artist.save
    new_artist
  end


  def genres
    genre_array = []
    @songs.each { |song| genre_array << song.genre}
    genre_array.uniq
  end

  def add_song(song)
    song.artist = self if song.artist == nil
    @songs << song if @songs.include?(song) == false

  end

  def save
    Artist.all << self
  end

  def self.all1

    all = Artist.all.select { |x| x.class == Artist }

    all
  end



end

class Genre
extend Concerns
extend Concerns::Findable
@@genres = []
attr_accessor :name, :songs, :artists

  def initialize(name)
    @name = name
    @songs = []

  end

  def artists
    artist_array = []
    @songs.each { |song| artist_array << song.artist}
    artist_array.uniq


  end

  def self.create(name)
    new_genre = Genre.new(name)
    new_genre.save
    new_genre
  end

  def save
    Genre.all << self
  end

  def self.all1

    all = Genre.all.select { |x| x.class == Genre }

    all
  end


end

class MusicImporter
  @@all = []
  attr_reader :path, :files

  def initialize(music_path)
        @path = music_path
        @files = Dir.entries(@path).delete_if { |e| e == "." || e == ".."  }


  end


  def import
    @files.each do |file|

      Song.create_from_filename(file)

    end




  end
end

class MusicLibraryController

  def initialize(music_path = "./db/mp3s")
        @path = music_path
        new_music = MusicImporter.new(@path)
        new_music.import


  end


  def call

      input = nil
    until input == "exit"
      input = gets

      if input == "play song"
        input = gets.to_i
        songs_array = Song.all
        songs_array = songs_array.select { |e| e.class == Song }
        strings = []
        songs_array.each { |song| strings << "#{song.artist.name} - #{song.name} - #{song.genre.name}"}
        puts "Playing #{strings[input - 1]}"

      elsif input == "list songs"
        songs_array = Song.all
        songs_array = songs_array.select { |e| e.class == Song }
        strings = []
        songs_array.each { |song| strings << "#{song.artist.name} - #{song.name} - #{song.genre.name}"}
        strings.sort!.each_with_index { |string, index| puts "#{index + 1}. #{string}" }


      elsif input == "list artists"
        songs_array = Song.all
        songs_array = songs_array.select { |e| e.class == Song }
        strings = []
        songs_array.each { |song| strings << "#{song.artist.name}"}
        strings.sort!.uniq.each { |string, index| puts "#{string}" }
      elsif input == "list genres"
        songs_array = Song.all
        songs_array = songs_array.select { |e| e.class == Song }
        strings = []
        songs_array.each { |song| strings << "#{song.genre.name}"}
        strings.sort!.uniq.each { |string, index| puts "#{string}" }
      elsif input == "list genre"
        input = gets
        songs_array = Song.all
        songs_array = songs_array.select { |e| e.class == Song }
        strings = []
        songs_array.each { |song| strings << "#{song.artist.name} - #{song.name} - #{song.genre.name}" if input == song.genre.name}
        strings.sort!.uniq.each { |string, index| puts "#{string}" }

      elsif input == "list artist"
        input = gets
        songs_array = Song.all
        songs_array = songs_array.select { |e| e.class == Song }
        strings = []
        songs_array.each { |song| strings << "#{song.artist.name} - #{song.name} - #{song.genre.name}" if input == song.artist.name}
        strings.sort!.uniq.each { |string, index| puts "#{string}" }



      end

    end


  end



end
