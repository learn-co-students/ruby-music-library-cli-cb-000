class MusicLibraryController
  
  
  
  def initialize(path = "./db/mp3s")
    
    MusicImporter.new(path).import
    
  end
  
  def call 
    user_input = ''
      while user_input != "exit" do 
      puts "Welcome to your music library!"
      puts "To list all of the artists in your library, enter 'list artists'."
      puts "To list all of your songs, enter 'list songs'."
      puts "To list all of the genres in your library, enter 'list genres'."
      puts "To list all of the songs by a particular artist, enter 'list artist'."
      puts "To list all of the songs of a particular genre, enter 'list genre'."
      puts "To play a song, enter 'play song'."
      puts "What would you like to do?"
      puts "To quit, type 'exit'."
      user_input = gets
      
      case user_input
      when "list artists"
        list_artists
      when "list songs"
        list_songs
      when "list genres"
        list_genres
      when "list artist"
        list_songs_by_artist
      when "list genre"
        list_songs_by_genre
      when "play song"
        play_song
      when "exit"
        break
      else
        puts "Enter a listed value"
      end
    end
    
  end
  
  def list_songs
    song_list =Song.all.sort{|x,y| x.name <=> y.name }
    song_list.each do |x|
    puts "#{song_list.index(x) + 1}. #{x.artist.name} - #{x.name} - #{x.genre.name}"
    end
  end
  
  def list_artists
    artist_list =Artist.all.sort{|x,y| x.name <=> y.name }
    artist_list.each do |x|
    puts "#{artist_list.index(x) + 1}. #{x.name}"
    end
  end
  
  def list_genres
    genre_list =Genre.all.sort{|x,y| x.name <=> y.name }
    genre_list.each do |x|
    puts "#{genre_list.index(x) + 1}. #{x.name}"
    end
  end
  
  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    requested_artist = gets
    song_list =Song.all.sort{|x,y| x.name <=> y.name }
    song_list = song_list.select{|y| y.artist.name == requested_artist}
    
    song_list.each do |x|
         puts "#{song_list.index(x) + 1}. #{x.name} - #{x.genre.name}"
      end
  end
  
  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    requested_genre = gets
    song_list =Song.all.sort{|x,y| x.name <=> y.name }
    song_list = song_list.select{|y| y.genre.name == requested_genre}
    
    song_list.each do |x|
         puts "#{song_list.index(x) + 1}. #{x.artist.name} - #{x.name}"
      end
  end
  
  def play_song
    puts "Which song number would you like to play?"
    requested_song = gets
    song_list =Song.all.sort{|x,y| x.name <=> y.name }
    song_list = song_list.select{|y| song_list.index(y) == requested_song.to_i - 1}
    song_list.each do |x|
      puts "Playing #{x.name} by #{x.artist.name}"
    end
  end
end