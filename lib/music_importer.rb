require 'pry'

class MusicImporter
    attr_accessor :path, :song, :genre, :artist

    def initialize(path)
        @path = path
    end

    def files # returns all of the imported filenames
        Dir["#{path}/*"].collect { |filename| filename.gsub("#{path}/", "")}
    end

    def import # imports all files from the library. Instantiating a new song object for each file
        files.each do |file|
            Song.create_from_filename(file)
        end
    end
end