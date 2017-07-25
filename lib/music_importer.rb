class MusicImporter
  attr_reader :path

  def initialize(filepath)
    @path = filepath
  end

  # path: './spec/fixtures/mp3s'
  def files
    Dir["#{self.path}/*.mp3"].collect do |file|
      file.split('/').last
    end
  end

  # create each song instance (and artist & genre where req'd) - returns array of filenames
  def import
    self.files.each {|filename| Song.create_from_filename(filename)}
  end
end
