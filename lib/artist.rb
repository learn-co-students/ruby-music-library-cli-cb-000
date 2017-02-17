class Artist
	attr_accessor :songs
	extend NamedListable::ClassMethods, Concerns::Findable
	include NamedListable::InstanceMethods

	def initialize(name)
		super
		@songs = []
	end

	def add_song(song)
			@songs << song  unless @songs.include?(song)
			song.artist= self unless song.artist==self
	end

	def genres
		@songs.collect {|song| song.genre}.uniq
	end

end
