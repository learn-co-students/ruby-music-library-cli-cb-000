class MusicImporter
  attr_accessor :path

  def initialize(path)
    @path = path
  end

  def files
    list = Dir["#{@path}/*.mp3"]
    list.collect{|item|
      #item.slice!(".mp3")
      #/**
      item.slice!("#{@path}/")
      item
    }
  end

  def import
    files.each{|file|Song.create_from_filename(file)}
  end

end
