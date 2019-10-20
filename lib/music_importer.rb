require 'pry'

class MusicImporter

	attr_reader :path, :files

	def initialize(path)
		@path = path
	end

	def files
		Dir.entries(@path).select {|f| !File.directory? f}
	end

	def import
		self.files.sort.each{ |file| Song.create_from_filename(file)}
	end

end