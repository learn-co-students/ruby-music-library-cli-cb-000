require "pry"
class MusicImporter

  attr_accessor :file_path

  def initialize(file_path)
    @path = file_path
  end

  def path
    @path
  end

  def files
    files = Dir.entries("#{path}/").select do |file|
      file.match(/.mp3/)
    end
    # full_file_names.each do |full_file_name|
    #   attributes = full_file_name.delete_suffix!(".mp3").split('-').each {|word| word.strip}
    # end
    files
  end

  def import
    files.each do |filename|
      Song.create_from_filename(filename)
    end
  end
end
