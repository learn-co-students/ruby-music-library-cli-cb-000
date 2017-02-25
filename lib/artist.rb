require "pry"


class Artist

	attr_accessor :name, :songs, :genre
	extend Concerns::Findable

	@@all = []
		
	def initialize(name)
		@name = name
		@songs = []
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

	def self.create(name)
		new(name).tap{ |artist| artist.save }
	end

	def songs
		@songs
	end

	def add_song(song)
		song.artist = self unless song.artist == self
		@songs << song unless songs.include?(song)

	end

	def genres
		genres = @songs.collect {|song| song.genre}.uniq
		genres
	end
	
	def to_string
		"#{self.artist.name} - #{self.name} - #{self.genre.name}"
	end
end