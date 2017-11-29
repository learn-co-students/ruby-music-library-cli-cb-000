class MusicLibraryController

  def initialize(path = "./db/mp3s")
    MusicImporter.new(path).import
  end

  def call
    puts "Welcome to your music library!"
    puts "To list all of your songs, enter 'list songs'."
    puts "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the genres in your library, enter 'list genres'."
    puts "To list all of the songs by a particular artist, enter 'list artist'."
    puts "To list all of the songs of a particular genre, enter 'list genre'."
    puts "To play a song, enter 'play song'."
    puts "To quit, type 'exit'."
    puts "What would you like to do?"
    input = gets.strip
    while input != "exit" do
      if input == "list songs"
        self.list_songs
        puts "What would you like to do?"
        input = gets.strip
      elsif input == "list artists"
        self.list_artists
        puts "What would you like to do?"
        input = gets.strip
      elsif input == "list genres"
        self.list_genres
        puts "What would you like to do?"
        input = gets.strip
      elsif input == "list artist"
        self.list_songs_by_artist
        puts "What would you like to do?"
        input = gets.strip
      elsif input == "list genre"
        self.list_songs_by_genre
        puts "What would you like to do?"
        input = gets.strip
      elsif input == "play song"
        self.play_song
        puts "What would you like to do?"
        input = gets.strip
      else
        puts "Not a valid command"
        puts "Please enter a valid command:"
        input = gets.strip
      end
    end
    exit
  end

  def list_songs
    num = 1
    Song.all.sort_by{|song| song.name}.each do |song|
      puts "#{num}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
      num += 1
    end
  end

  def list_artists
    num = 1
    Artist.all.sort_by!{|artist| artist.name}.each do |artist|
      puts "#{num}. #{artist.name}"
      num += 1
    end
  end

  def list_genres
    num = 1
    Genre.all.sort_by!{|genre| genre.name}.uniq.each do |genre|
      puts "#{num}. #{genre.name}"
      num += 1
    end
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    input = gets
    artist = Artist.find_by_name(input)
    if artist
      num = 1
      artist.songs.sort_by{|song| song.name}.each do |song|
        puts "#{num}. #{song.name} - #{song.genre.name}"
        num += 1
      end
    end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    input = gets.strip
    genre = Genre.find_by_name(input)
    if genre
      num = 1
      genre.songs.sort_by{|song| song.name}.each do |song|
        puts "#{num}. #{song.artist.name} - #{song.name}"
        num += 1
      end
     end
   end

   def play_song
     puts "Which song number would you like to play?"
     input = gets.strip.to_i
     if input >= 1 && input < Song.all.size
       list = Song.all.sort_by{|song| song.name}
       puts "Playing #{list[input-1].name} by #{list[input-1].artist.name}"
     end
   end
end
