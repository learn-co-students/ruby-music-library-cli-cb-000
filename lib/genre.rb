class Genre

	attr_accessor :name, :songs

	extend Concerns::Findable

	@@all = []

	def initialize(name)
		@name = name
		@songs = []
	end

	def self.all
		@@all
	end

	def save
		self.class.all << self
	end

	def add_song(song)
		self.songs << song unless self.songs.any?{|obj| obj == song}
	end

	def self.create(name)
		self.new(name).tap(&:save)
	end

	def self.print_all
		self.all.each { |obj| puts obj.name }
	end

	def self.destroy_all
		@@all.clear
	end

	def artists
		self.songs.collect(&:artist).uniq
	end

end