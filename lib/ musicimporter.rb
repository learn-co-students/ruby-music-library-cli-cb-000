class MusicImporter

 attr_accessor :path


def initialize(path)
 @path = path
end

def files
  directory = Dir["#{self.path}/*"]
  directory.map do |file|
    file.slice!(self.path + "/")
  end
  return directory



end



def import
  self.files.each do |file|
    Song.create_from_filename(file)
  end
end


end
