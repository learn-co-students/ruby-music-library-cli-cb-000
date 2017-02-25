require "pry"


class Genre


	attr_accessor :name
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

	def songs
		@songs
	end

	def self.create(name)
		new(name).tap{ |genre| genre.save}
	end

	def artists
		artists = @songs.collect {|s| s.artist}.uniq
		artists
	end

	def to_string
		"#{self.artist.name} - #{self.name} - #{self.genre.name}"
	end
end