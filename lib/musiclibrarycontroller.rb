require "pry"
class MusicLibraryController

  attr_accessor :path

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
        when "list artist"
          list_artist
        when "list genre"
          list_genre
        when "play song"
          play_song
      end
    end
  end

  def songs
    Song.all.each.with_index(1) {|i, v| puts "#{v}. #{i.artist.name} - #{i.name} - #{i.genre.name}"}
  end

  def artists
    Artist.all.each.with_index(1) do |a, i|
      puts "#{i}. #{a.name}"
    end
  end

  def genres
    Genre.all.each.with_index(1) do |g, i|
      puts "#{i}. #{g.name}"
    end
  end

  def play_song
    # binding.pry
    puts "Please select a song number:"
    user_input = gets.chomp.strip
    puts "Playing #{Song.all[user_input.to_i - 1].artist.name} - #{Song.all[user_input.to_i - 1].name} - #{Song.all[user_input.to_i - 1].genre.name}"
    # binding.pry
  end

  def list_artist
    puts "Select an artist to check the collection of songs"
    user_input = gets.chomp
    if artist = Artist.find_by_name(user_input)
      # binding.pry
      artist.songs.each do |s|
        puts "#{s.artist.name} - #{s.name} - #{s.genre.name}"
      end
    end
  end

  def list_genre

    puts "Select a genre song collection."
    user_input = gets.chomp
    if genre = Genre.find_by_name(user_input)
      genre.songs.each do |s|
        puts "#{s.artist.name} - #{s.name} - #{s.genre.name}"
      end
    end
  end

end
