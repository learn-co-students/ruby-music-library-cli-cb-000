class MusicLibraryController

  def initialize(path = "./db/mp3s")
    importer = MusicImporter.new(path)
    importer.import
  end

  def call
    input = ""

    while input != "exit"
      puts "Welcome to Your Music Library!"
      puts "What would you like to do?"

      input = gets.strip

      case input

        when "list songs"
          songs
        when "list artists"
          artists
        when "list genres"
          genres
        when "play song"
          play
        when "list artist"
          list_artist
        when "list genre"
          list_genre
      end
    end
  end

  def songs
    Song.all.each_with_index do |s, i|
      puts "#{i + 1}. #{s.artist.name} - #{s.name} - #{s.genre.name}"
    end
  end

  def artists
    Artist.all.each do |a|
      puts "#{a.name}"
    end
  end

  def genres
    Genre.all.each do |g|
      puts "#{g.name}"
    end
  end

  def play
    puts "What song number would you like to play?"
    song_num = gets.strip
    puts "Playing #{Song.all[song_num.to_i - 1].artist.name} - #{Song.all[song_num.to_i - 1].name} - #{Song.all[song_num.to_i - 1].genre.name}"
  end

  def list_artist
    puts "Which artist?"
    artist = gets.strip
    Artist.all.detect { |a| a.name.downcase == artist.downcase }.songs.each do |s|
      puts "#{s.artist.name} - #{s.name} - #{s.genre.name}"
    end
  end

  def list_genre
    puts "Which genre?"
    genre = gets.strip
    Genre.all.detect { |g| g.name.downcase == genre.downcase }.songs.each do |s|
      puts "#{s.artist.name} - #{s.name} - #{s.genre.name}"
    end
  end
end
