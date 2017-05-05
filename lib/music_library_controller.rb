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
      when "list genres"
        genres
      when "list artists"
        artists
      when "list genre"
        list_genre
      when "list artist"
        list_artist
      when "play song"
        play_song
      end
    end
  end

  def artists
    Artist.all.each.with_index(1) do |a, i|
      puts "#{i}. #{a}"
    end
  end

  def genres
    Genre.all.each.with_index(1) do |g, i|
      puts "#{i}. #{g}"
    end
  end

  def list_artist
    puts "Which artist would you like to view?"
    artist_input = gets.strip
    if artist = Artist.find_by_name(artist_input)
      artist.songs.each do |s, i|
        puts "#{i}. #{s}"
      end
    end
  end

  def list_genre
    puts "Which genre would you like to view?"
    genre_input = gets.strip
    if genre = Genre.find_by_name(genre_input)
      genre.songs.each do |g, i|
        puts "#{i}. #{g}"
      end
    end
  end

  def play_song
    puts "What song number would you like to play?"
    song_input = gets.strip
    puts "Playing #{Song.all[song_input.to_i-1]}"
  end

  def songs
    Song.all.each.with_index(1) do |s, i|
      puts "#{i}. #{s}"
    end
  end
end
