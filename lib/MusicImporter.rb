class MusicImporter
  attr_accessor :path
  require 'pry'
  def initialize(path)
    #accepts a file path to parse mp3 files from
    @path = path

  end

  def files
    #returns an array of file names
    @files ||= Dir.glob("#{path}/*.mp3").collect{ |f| f.gsub("#{path}/", "") }
    # binding.pry

  end

  def import
    # binding.pry
    # files.each{|f| Song.create_from_filename(f)}
    files.each do |f|
      # puts "current song is #{f}"
        # binding.pry

        Song.create_from_filename(f)
    end

    # files.each{|f| Song.new_from_filename(f)}
  end
end

#first song:
