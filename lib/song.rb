class Song
	extend NamedListable::ClassMethods, Concerns::Findable
	include NamedListable::InstanceMethods
	attr_reader :artist, :genre

	def self.create_from_filename(name)
		self.new_from_filename(name).tap {|song| song.save}
	end

	def self.new_from_filename(name)
		data = name.slice(0, name.rindex('.')).split(' - ')
		self.new(data[1].strip, Artist.find_or_create_by_name(data[0].strip),
		                        Genre.find_or_create_by_name(data[2].strip))
	end

	def initialize(name, artist=nil, genre=nil)
		super(name)
		self.artist = artist unless artist==nil
		self.genre = genre unless genre==nil
	end

	def artist=(artist)
		@artist = artist
		artist.add_song(self)
	end

	def genre=(genre)
		@genre = genre
		genre.add_song(self)
	end

end
