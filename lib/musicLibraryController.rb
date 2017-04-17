class MusicLibraryController
  attr_accessor :path
  def initialize(path="./db/mp3s")
    @path = path
    importer = MusicImporter.new(path)
    @songs = importer.import
  end
  def call
    input = gets.chomp
    while input!="exit"
      if input == "list songs"
        i=0
        @songs.each do |song|
          i+=1
          puts "#{i}. #{song.split(".")[0]}"
        end
      elsif input == "list artists"
        @songs.each do |song|
          puts "#{song.split(" - ")[0]}"
        end
      elsif input == "list genres"
        @songs.each do |song|
          puts "#{song.split(" - ")[2].split(".")[0]}"
        end
      elsif input == "play song"
        number = gets.chomp.to_i
        puts "Playing #{@songs[number-1].split(".")[0]}"
      elsif input == "list artist"
        artist = gets.chomp
        artist_songs = @songs.select{|song|song.include?(artist)}
        artist_songs.each{|song| puts "#{song.split(".")[0]}"}
      elsif input == "list genre"
        genre = gets.chomp
        genre_songs = @songs.select{|song|song.split(" - ")[2].split(".")[0] == genre}
        genre_songs.each{|song|puts "#{song.split(".")[0]}"}
      end

      input = gets.chomp
    end
  end
end
