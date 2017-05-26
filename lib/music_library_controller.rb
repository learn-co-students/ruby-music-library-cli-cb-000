class MusicLibraryController

  attr_accessor :path

  def initialize(path = './db/mp3s')
    @path = path
    music_importer = MusicImporter.new(path)
    music_importer.import
  end

  def call
    print "Input text: "
    input = gets.strip
    if input == "list songs"
      sorted_songs = Song.all.sort_by {|song| song.artist.name }
      sorted_songs.each_with_index do |song, index|
        puts "#{index+1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
      end
    elsif input == "list artists"
      Artist.all.each {|artist| puts "#{artist.name}"}
    elsif input == "list genres"
      Genre.all.each {|genre| puts "#{genre.name}"}
    elsif input == "play song"
      Song.all.each {|song| puts "Playing #{song.artist.name} - #{song.name} - #{song.genre.name}"}
    elsif input == "list artist"
      Artist.all.each do |artist|
        artist.songs.each do |song|
          puts "#{song.artist.name} - #{song.name} - #{song.genre.name}"
        end
      end
    elsif input == "list genre"
      Genre.all.each do |genre|
        genre.songs.each do |song|
          puts "#{song.artist.name} - #{song.name} - #{song.genre.name}"
        end
      end
    end
    unless input == "exit"
      self.call
    end
  end

end
