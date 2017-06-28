class MusicImporter

    attr_accessor :path

    def initialize( filepath )
      #puts "FilePath:#{filepath}!!!"
      @path = filepath
    end

    def files
      #puts "FileDir:#{@path}:"
      @files ||= Dir.glob("#{@path}/*.mp3").collect{ |e| e.split("mp3s/")[1] }
      #@files ||= Dir.entries(@path).select{ |e| File.file? e }

      @files
    end

    def import
      files.each do |fileName|
        #puts "Import FileName:#{fileName}"
        Song.create_from_filename( fileName )
      end
    end

end
