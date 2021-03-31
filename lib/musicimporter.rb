class MusicImporter
  attr_accessor(:path,:directory,:import)

  def initialize(path)
    @path=path
    @directory=Dir.new("#{path}")
    @import=true
    self
  end

  def files
    files=@directory.entries
    music_files=files.select{ |file_name| file_name.include?(".mp3") }
  end

  def import
    music_files=self.files
    music_files.each { |song_info| Song.create_from_filename(song_info) }
  end

end
