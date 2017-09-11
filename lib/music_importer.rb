class MusicImporter

attr_accessor :path

def initialize(path)
  @path = path
end

def files
     arr = []
     Dir.entries(path).each do |x|
       if x.include?(".mp3")
         arr << x
       end
     end
     arr
   end


   def import
      self.files.each do |song|
        Song.create_from_filename(song)
      end
    end


end
