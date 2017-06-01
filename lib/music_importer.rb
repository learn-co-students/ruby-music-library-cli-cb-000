class MusicImporter
  ### CLASS METHODS & VARIABLES ###


  class << self # establishes a block for defining class methods and fields

    # NOTE: following logic is encapsulated in class method here, since
    #   specification requires that Song class be able to access this
    #   method in conjunction with its required #new_from_filename class method.
    def import_file(file)
      file_components = file[0, file.length - 4].split(" - ")
      song = Song.new(file_components[1],
        Artist.find_or_create_by_name(file_components[0]),
        Genre.find_or_create_by_name(file_components[2]) )
      return song
    end
  end

  ### INSTANCE METHODS & VARIABLES ###
  attr_reader :path, :files

  def initialize(path)
    original_path = (Dir.pwd + "/").freeze
    @path = path
    Dir.chdir(original_path + path)
    @files = Array.new
    Dir.glob("*.mp3").each{|file| @files << file}
    Dir.chdir(original_path)
  end

  def import()
    files.each{ |file| MusicImporter.import_file(file) }
  end
end
