class MusicImporter

	attr_reader :path, :files

	def initialize(path)
		@path = path;
		@files = Dir.entries(path).find_all{|name| name.end_with?('.mp3')};
	end

	def import
		files.collect do |file|
			Song.create_from_filename(file)
		end
	end
	
end