class MusicImporter
	attr_accessor :path

	def initialize(path)
		@path = path
	end

	def files
		@mp3 = []
		@files = Dir.glob(@path + '/*.mp3')
		@files.each do |file|
			mp3 = file.sub("#{@path}/", "")
			@mp3 << mp3
		end
		@mp3
	end

	def import
		    self.files
			@files.each do |file|
				song = file.sub("#{@path}/", "")
				created_song = Song.create_from_filename(song)
				created_song
			end
	end


end