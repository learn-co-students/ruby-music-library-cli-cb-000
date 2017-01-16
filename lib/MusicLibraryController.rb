class MusicLibraryController
  attr_accessor :path

  def initialize(path="./db/mp3s")
    # @path = path
    tunes = MusicImporter.new(path)
    tunes.import
  end

  def call
    input = nil
    while input != "exit"
      input = gets.chomp
      case input
      when input == "list songs"
        # binding.pry
        list
      end
    end
  end

  def list
    Song.all.each_with_index(1){|x,index| "#{index}. #{x.name}"}
  end
end
