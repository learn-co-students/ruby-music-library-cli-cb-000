class Song

	attr_accessor :name
	attr_reader :artist, :genre

	@@all = []

	def initialize(name, artist=nil, genre=nil)
		@name = name
		self.artist = artist if artist
		self.genre = genre if genre
	end

	def artist=(artist)
		@artist = artist
		@artist.add_song(self)
	end

	def genre=(genre)
		@genre = genre
		@genre.add_song(self)
	end

	def self.all
		@@all
	end

	def save
		self.class.all << self
	end

	def self.create(name)
		self.new(name).tap(&:save)
	end

	def self.destroy_all
		@@all.clear
	end

	def self.find_by_name(name)
		self.all.detect { |obj| obj.name == name }
	end

	def self.find_or_create_by_name(name)
		self.find_by_name(name) || self.create(name)
	end

	def self.parse_filename(filename)
		data = filename.gsub('.mp3', '').split(' - ')
		{ song: data[1], artist: data[0], genre: data[2] }
	end

	def self.new_from_filename(filename)
		data = self.parse_filename(filename)
		genre = Genre.find_or_create_by_name(data[:genre])
		artist = Artist.find_or_create_by_name(data[:artist])
		song = self.new(data[:song], artist, genre)
	end

	def self.create_from_filename(filename)
		self.new_from_filename(filename).tap(&:save)
	end

	def self.print_with_index
		self.all.each_with_index do |obj, idx|
			puts "#{idx + 1}. #{self.print_song(obj)}"
		end
	end

	def self.print_song(song)
		"#{song.artist.name} - #{song.name} - #{song.genre.name}"
	end

end