class MusicLibraryController
  attr_accessor :path, :importer
  def initialize(path='./db/mp3s')
    @path = path
    @importer = MusicImporter.new(path)
    @importer.import
  end
end
