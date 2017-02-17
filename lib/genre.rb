class Genre
	attr_accessor :songs
	extend NamedListable::ClassMethods, Concerns::Findable
	include NamedListable::InstanceMethods

	def initialize(name)
		super
		@songs = []
	end

	def add_song(song)
			@songs << song  unless @songs.include?(song)
			song.genre= self unless song.genre==self
	end

	def artists
		@songs.collect {|song| song.artist}.uniq
	end

end
