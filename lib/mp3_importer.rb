class MusicImporter
  attr_accessor :path
  def initialize(path)
    @path = path

end

def files
  # Dir["/path/to/search/**/*.rb"]
  # didnt have to
  # cut = @path[/.*\//]
  raw = Dir[@path + "/*"]

  raw.collect {|file| File.basename file }
end
#
def import
  self.files.each do |file|
    # Artist.find_or_create_by_name(file)
    Song.create_from_filename(file)
  end
end
end
