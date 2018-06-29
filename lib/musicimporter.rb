class MusicImporter

    attr_accessor :path, :files

    def initialize(path)
        @path = path
    end

    def files
        @files = []
        Dir.entries(@path).each{ |file|
            @files << file.chomp(".mp3") if file.end_with?(".mp3")
        }
        @files
    end

    def import
        files.each {|file|
            Song.create_from_filename(file)
        }
    end

end
