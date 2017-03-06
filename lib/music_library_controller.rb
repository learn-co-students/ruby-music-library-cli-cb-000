class MusicLibraryController
  def initialize(path="./db/mp3s")
    @path=path
    importer=MusicImporter.new(@path)
    importer.import
  end

  def call

    input=gets.strip
    
    if input=="list songs"
      Song.all.each do |song|
        puts "#{song.print}"
      end
    elsif input=="list genres"
      Genre.all.each {|genre| puts "#{genre.name}"}
    elsif input=="list artists"
      Artist.all.each {|artist| puts "#{artist.name}"}
    elsif input=="play song"
      num=gets.chomp.to_i
      song=Song.all[num-1]
      puts "Playing #{song.artist.name} - #{song.name} - #{song.genre.name}"
    elsif input=="list artist"
      artist=gets
      Artist.find_by_name(artist).songs.each do |song|
        puts "#{song.print}"
      end
    elsif input=="list genre"
      genre=gets
      Genre.find_by_name(genre).songs.each do |song|
        puts "#{song.print}"
      end
    end

    self.call unless input=="exit"
  end
end
