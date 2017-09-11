require 'pry'
class MusicImporter

  attr_accessor :path, :filenames

  def initialize(path)
    @path = path
    @filenames = []
  end

  def files
    dir = Dir.new(self.path)
    dir.each {|e| self.filenames << e if e[".mp3"] == ".mp3"}
    self.filenames
  end

  def import
    self.files.each {|e| Song.create_from_filename(e)}
  end

end
