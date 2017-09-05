require 'pry'

class Song
	attr_accessor :name, :artist, :genre

	@@all = []

	def initialize(name, artist=nil, genre=nil)
		@name = name
		@artist = artist
		self.artist = @artist
		self.genre = genre
	end 

	def self.genre
		if @artist == nil && @genre == nil
			  return []
		elsif @artist != nil && self.genre != nil
			self.genre.add_song(@artist)
			self.genre
		end
	end

	def genre=(genre)
		if genre != nil
			if genre.songs.include?(self)
				genre.songs
			else
				@genre = genre
				genre.add_song(self)
			end
		end
	end

	def artist=(artist)
		#artist.name = @name
		#artist.add_song(@@all)
		if artist == nil
			@artist = artist
		elsif artist != nil
			@artist = artist
			artist.add_song(self)
		end
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

	def self.save
		@@all << self
	end

	def self.find_by_name(name)
		#finds a song instance in @@all by the name property of the song
		@found = []
		if name == nil
			return "Error:could not find song"
		elsif name != nil
			self.all.find do |song|
				if song.name == name
					@found << song
					@found.first
				end
			end
		end
	end

	def self.create(name)
		new_song = Song.new(name)
		new_song.save
		new_song
	end

	def self.find_or_create_by_name(name)
		self.find_by_name(name)
		if name != nil && @found == nil
			new_song = Song.new(name)
			new_song.save
			new_song
		elsif @found[0] != nil 
			@found[0]
		elsif @found.length == 0
			self.create(name)
		end
	end

	def self.new_from_filename(filename)
		@filename = filename
		if @filename == nil
			puts "Error: No songname detected"
		elsif @filename.length != 0	
				@filename = @filename.sub(".mp3", "")
				@filename = @filename.split(" - ")
				artist = Artist.find_or_create_by_name(@filename[0])
				genre = Genre.find_or_create_by_name(@filename[2])
				song = self.find_or_create_by_name(@filename[1])
				song.artist = artist
				song.genre = genre 
				song
		end
	end

	def self.create_from_filename(filename)
		song = self.new_from_filename(filename)
		song.save
		song
	end
end