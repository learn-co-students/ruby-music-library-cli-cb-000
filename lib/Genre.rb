class Genre
	attr_accessor :name, :song, :artist

	@@all = []

	extend Concerns::Findable 

	def initialize(name)
		@name = name
		@songs = []
	end

	def artists
		@artists = self.songs.collect do |song|
			song.artist
		end 
		@artists.uniq
	end

	def songs
		@songs
	end

	def add_song(song)
		@songs << song
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
		genre = Genre.new(name)
		genre.save
		genre
	end

end