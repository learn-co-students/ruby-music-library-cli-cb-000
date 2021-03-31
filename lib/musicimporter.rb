class MusicImporter

  def initialize(file_directory)
    @path = file_directory
  end

  def path
    @path
  end

  def path=(file_directory)
    @path = file_directory
  end

  def files
    @files = []
    temp_files = Dir.new(@path).entries
    temp_files.each do |file_name|
      if file_name != "." && file_name != ".."
        @files << file_name
      end
    end
    @files
  end

  def import
    self.files
    array_of_imports = []
    @files.each do |filename|
      new_song = Song.create_from_filename(filename)
      array_of_imports << new_song
    end
    array_of_imports
  end

end
