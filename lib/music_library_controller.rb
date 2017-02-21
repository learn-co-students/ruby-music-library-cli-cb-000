=begin
class MusicLibraryController
  attr_accessor :importer
  def initialize(path="./db/mp3s")
    @importer = MusicImporter.new(path)
    importer.import
  end

  def call
    puts "Please enter a command!"
    command = " "

    until command == "exit"
      "What would you like to do?"
      command = gets.strip
      case command

      when "list songs"
         Song.all.each_with_index{|song, i| 
         puts "#{i+1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"}
      when "list artists"
        Artist.all.each{|artist| puts artist.name}
      when "list genres" 
        Genre.all.each{|genre| puts genre.name}
      when "play song"
        song = gets
        song = song.to_i
        file_name = Song.all[song - 1]
        puts "Playing #{file_name.artist.name} - #{file_name.name} - #{file_name.genre.name}"


      when "list artist"
        artist = gets
        artist = Artist.find_by_name(artist)
        artist.songs.each{|a| puts "#{artist.name} - #{a.name} - #{a.genre.name}"}
      when "list genre"
        genre = gets
        genre = Genre.find_by_name(genre)
        genre.songs.each{|x| puts "#{x.artist.name} - #{x.name} - #{x.genre.name}"}
      end
    end
  end

end
=end
class MusicLibraryController

  def initialize(path="./db/mp3s")
    #create new MusicImporter and import files
    importer = MusicImporter.new(path)
    importer.import
  end

  def call
    input = ""
    while input != "exit" do
      puts "Welcome to Your Music Library!"
      puts "What would you like to do?"
      input = gets.strip

      case input
      when "list songs"
        list_songs
      when "list artists"
        list_artists
      when "list genres"
        list_genres
      when "play song"
        play_song
      when "list artist"
        list_artist
      when "list genre"
        list_genre
      end
    end
  end

  def list_songs
    #in this format "1. <artist> - <song> - <genre>"
    #the each.with_index(1) tells index to start at 1 instead of 0
    counter = 1
    Song.all.sort_by{|song| song.artist.name.downcase}.each do |song|
      puts "#{counter}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
      counter += 1
    end
  end

  def list_artists
    counter = 1
    Artist.all.each do |a|
      puts "#{counter}. #{a.name}"
      counter += 1
    end
  end

  def list_genres
    counter = 1
    Genre.all.each do |g|
      puts "#{counter}. #{g.name}"
      counter += 1
    end
  end

  def play_song
    puts "What song number would you like to play?"
    song_input = gets.strip
    ps = Song.all[song_input.to_i-1]

    puts "Playing #{ps.artist.name} - #{ps.name} - #{ps.genre.name}"

  end

  def list_artist
    puts "Name the artist you would like to list songs for?"
    artist_input = gets.strip
    #have to make sure artist is valid
    counter = 1
    artist = Artist.find_by_name(artist_input)
    if artist
      artist.songs.each do |song|
        puts "#{counter}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
        counter += 1
      end
    end
  end


  def list_genre
    puts "Pick a genre to list songs for?"
    genre_input = gets.strip
    #have to make sure artist is valid
    counter = 1
    genre = Genre.find_by_name(genre_input)
    if genre
      genre.songs.each do |song|
        puts "#{counter}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
        counter += 1
      end
    end
  end


end