require "fileutils"

class MusicImporter
    attr_accessor :path, :files

    def initialize(path)
        @path = path
        @files = []
        @files = Dir.entries(path)
        #remove dot directories
        @files.delete_if{ |x| x == ".."  || x == "."}
        #spec wants .mp3 to be passed through with filename
        #for each file, remove .mp3
        #filenames.each { |x| @files << File.basename(x, ".mp3")}
    end

    def import
        @files.each{ |song| Song.create_from_filename(song)}
    end 
       
end