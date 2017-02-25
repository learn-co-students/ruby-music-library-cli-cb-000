require "pry"


class Song

	attr_accessor :name, :artist, :genre

	@@all = []

	def initialize(name, artist = nil, genre = nil)
		@name = name
		self.artist=(artist) if artist
		self.genre=(genre) if genre
	end

	def artist=(artist)
		@artist = artist
		artist.add_song(self)
	end

	def genre=(genre)
		@genre = genre
		genre.songs << self unless genre.songs.include?(self)
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

	def self.create(name, artist = nil, genre = nil)
		new(name, artist, genre).tap{ |song| song.save}
	end

	def self.find_by_name(name)
		self.all.detect{ |song| song.name == name}
	end

	def self.find_or_create_by_name(name)
		if(self.find_by_name(name))
			self.find_by_name(name)
		else
			self.create(name)
		end
	end

	def self.new_from_filename(filename)
		new_song = filename.split(" - ")
		
		artist = Artist.find_or_create_by_name(new_song[0])
		song = new_song[1]
		genre = Genre.find_or_create_by_name(new_song[2].chomp(".mp3"))

		self.new(song, artist, genre)
	end

	def self.create_from_filename(filename)
		new_song = filename.split(" - ")
		
		artist = Artist.find_or_create_by_name(new_song[0])
		song = new_song[1]
		genre = Genre.find_or_create_by_name(new_song[2].chomp(".mp3"))

		self.create(song, artist, genre)
	end

	def to_string
		"#{self.artist.name} - #{self.name} - #{self.genre.name}"
	end

end