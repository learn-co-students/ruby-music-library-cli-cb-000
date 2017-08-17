# implements music importer for music library
require 'pry'
class MusicImporter
  attr_accessor :path

  @files = []

  def initialize(path)
    @path = path
    @files = files
  end

  def files
    files = Dir["#{path}/*"]
    song_names = []
    files.each do |file|
      song_names << file.split(%r{/})[4].lstrip
    end
    song_names
  end

  def import
    @files.each { |file| Song.create_from_filename(file) }
  end
end
