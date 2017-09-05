require 'pry'

class Artist
	attr_accessor :name, :songs, :genres

	extend Concerns::Findable 

	@@all = []

	def initialize(name)
		@name = name
		@songs = []
		self.songs = @songs
	end

	def genres
		@genres = self.songs.collect do |song|
			song.genre
    	end
    	@genres.uniq
	end

	def self.songs
		@songs
	end

	def songs 
		@songs
	end
	
	def add_song(song)
		@songs.include?(song) ? @songs : @songs << song
		song.artist == nil ? song.artist = self : @songs
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
		artist = Artist.new(name)
		artist.save
		artist
	end
end
