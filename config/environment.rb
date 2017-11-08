require 'bundler'
require 'pry'
Bundler.require

module Concerns
end

require_all 'lib'



class Song
  attr_accessor :name
  attr_reader :artist, :genre

  @@all = []

  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist=(artist) unless artist == nil
    self.genre=(genre) unless genre == nil
    @@all << self
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

  def self.find_by_name(name)
    x = false
    @@all.each do |song|
      if song.name == name
        x = song
      end
    end
    return x
  end

  def self.create(name)
    Song.new(name)
  end

  def self.find_or_create_by_name(name)
    self.find_by_name(name) || self.create(name)
  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end

  def genre=(genre)
    @genre = genre
    genre.songs << self unless genre.songs.include?(self)
  end

  def self.new_from_filename(filename)
    file = filename.split(" - ")
    n = file[1]
    a = Artist.find_or_create_by_name(file[0])
    g = Genre.find_or_create_by_name(file[2].chomp(".mp3"))
    song = Song.new(n, a, g)
  end

  def self.create_from_filename(filename)
    self.new_from_filename(filename)
  end

end







class Artist
  attr_accessor :name, :song, :songs, :genre
  extend Concerns::Findable

  @@all = []

  def initialize(name)
    @name = name
    @songs = []
    @@all << self
  end

  def songs
    @songs
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

  def genres
    arr = []
    self.songs.each do |song|
      arr << song.genre unless arr.include?(song.genre)
    end
    arr
  end


  def self.create(name)
    artist = Artist.new(name)
  end

  def add_song(song)
    if song.artist == nil
      song.artist = self
    end
    self.songs << song unless self.songs.include?(song)
  end
end








class Genre
  attr_accessor :name
  extend Concerns::Findable

  @@all = []

  def initialize(name)
    @name = name
    @songs = []
    @@all << self
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

  def songs
    @songs
  end

  def artists
    arr = []
    self.songs.each do |song|
      arr << song.artist unless arr.include?(song.artist)
    end
    arr
  end

  def self.create(name)
    genre = Genre.new(name)
  end
end



class MusicImporter
  require 'open-uri'
  attr_accessor :path

  @@mp3s= []

  def initialize(path)
    @path = path
  end

  def files
    files = Dir.entries(path)
    files.collect do |string|
      if string.length < 10
        files.delete(string)
      end
    end
    files
  end

  def import
    self.files.each do |file|
      Song.create_from_filename(file)
    end
  end

  def mp3s
    @@mp3s
  end
end


class MusicLibraryController
  attr_accessor :path

  def initialize(path = './db/mp3s')
    @path = path
    music_importer = MusicImporter.new(path)
    music_importer.import
  end

  def call
    puts "Welcome to your music library!"
    puts "To list all of your songs, enter 'list songs'."
    puts "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the genres in your library, enter 'list genres'."
    puts "To list all of the songs by a particular artist, enter 'list artist'."
    puts "To list all of the songs of a particular genre, enter 'list genre'."
    puts "To play a song, enter 'play song'."
    puts "To quit, type 'exit'."
    puts "What would you like to do?"
    if gets != exit
      if gets == 'list songs'
        self.list_songs
      elsif
        gets == "list artists"
        self.list_artists
      elsif
        gets == "list genres"
        self.list_genres
      elsif
        gets == "list artist"
        self.list_songs_by_artist
      elsif
        gets == "list genre"
        self.list_songs_by_genre
      end
    else
      gets
    end
  end

  def song_sort
    list = Song.all.sort_by!{|song| song.name}
    list
  end

  def list_songs
    i = 1
    self.song_sort.each do |songs|
      puts "#{i}. #{songs.artist.name} - #{songs.name} - #{songs.genre.name}"
      i += 1
    end
  end

  def list_artists
    list = Artist.all.sort_by!{|artist| artist.name}
    list
    i = 1
    list.each do |artist|
      puts "#{i}. #{artist.name}"
      i += 1
    end
  end

  def list_genres
    list = Genre.all.sort_by!{|genre| genre.name}
    list
    i = 1
    list.each do |genre|
      puts "#{i}. #{genre.name}"
      i += 1
    end
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    gets
    list = Song.all.sort_by!{|song| song.name}
    i = 1
    list.each do |song|
      if song.artist.name == gets
        puts "#{i}. #{song.name} - #{song.genre.name}"
        i += 1
      end
    end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    gets
    i = 1
    self.song_sort.each do |song|
      if song.genre.name == gets
        puts "#{i}. #{song.artist.name} - #{song.name}"
        i += 1
      end
    end
  end

  def play_song
    puts "Which song number would you like to play?"
    i = gets.to_i
    if i > 0 && i < 5
      songs = self.song_sort[i-1]
      puts "Playing #{songs.name} by #{songs.artist.name}"
    end
  end



end
