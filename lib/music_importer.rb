# class MusicImporter
#   attr_reader :path
#
#   def initialize(path)
#     @path = path
#   end
#
#
#   def files
#     @path_directory = Dir["#{@path}/*.mp3"]
#     @path_directory.map! do |path|
#       path.gsub!(/\.\/spec\/fixtures\/mp3s\//, "")
#     end
#   end
#
#
#   def import
#     files.each do |file|
#       Song.create_from_filename(file)
#     end
#   end
#
# end



class MusicImporter
  attr_reader :path

  def initialize(path)
    @path = path
  end

  def files
    @files ||= Dir.glob("#{path}/*.mp3").collect{ |f| f.gsub("#{path}/", "") }
  end

  def import
    files.each{ |f| Song.create_from_filename(f) }
  end
end
