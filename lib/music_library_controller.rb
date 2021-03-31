class MusicLibraryController
  attr_reader :library

  def initialize(path = './db/mp3s')
    @library = MusicImporter.new(path).import
  end

  def call
    exit_loop = false
    until exit_loop == true
      puts "Type 'list songs', 'list artists', 'list genres', 'play song', 'list artist', 'list genre' or 'exit'."
      answer = gets.strip
      case answer
      when "list songs"
        list_songs
      when "list artists"
        list_artists
      when "list genres"
        list_genres
      when "play song"
        puts "Select song to play?"
        song_to_play = gets.strip.to_i
        puts "Playing #{@library[song_to_play - 1]}"
      when "list artist"
        puts "Enter artist name"
        artist_name = gets.strip
        list_artist_songs(artist_name)
      when "list genre"
        puts "Enter genre"
        genre_name = gets.strip
        list_genres_songs(genre_name)
      when "exit"
        exit_loop = true
      end
    end
  end

  def list_songs
    @library.each_with_index do |file, index|
      puts "#{index + 1}. #{file[0..file.size - 5]}"
    end
  end

  def list_artists
    @library.each do |file|
      song_attr = file.split(" - ")
      puts "#{song_attr[0]}"
    end
    puts "Enter the artist name to list songs"
  end

  def list_genres
    @library.each_with_index do |file, index|
      puts "#{index + 1}. #{file}"
    end
  end

  def list_artist_songs(artist)
    @library.each_with_index do |file, index|
      song_attr = file.split(" - ")
      puts "#{@library[index]}" unless song_attr[0] != artist
    end
  end

  def list_genres_songs(genre)
    @library.each_with_index do |file, index|
      song_attr = file[0..file.size - 5].split(" - ")
      puts "#{@library[index]}" unless song_attr[2] != genre
    end
  end

end
