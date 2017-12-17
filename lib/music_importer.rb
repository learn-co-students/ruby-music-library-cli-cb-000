require 'pry'

class MusicImporter
  attr_accessor :path, :files

  def initialize(path)
    @path = path
    @files = []
    Dir.new(path).each { |file| @files << file unless file == "." || file == ".."}
  end

  def import
    files.each {|file| Song.create_from_filename(file)}
  end
end
