class MusicLibraryController
  def initialize(path='./db/mp3s')
    MusicImporter.new(path).import
  end
  
  def call
    input = ''
    
    until input == 'exit' do
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
      case input
      when 'list songs'
        list_songs
      when 'list artist'
        list_songs_by_artist
      when 'list genre'
        list_songs_by_genre
      when 'list artists'
        list_artists
      when 'list genres'
        list_genres
      when 'play song'
        play_song
      end
    end
  end
  
  def list_songs
    x = 1
    orderedSongs = Song.all.sort {|a,b| a.name <=> b.name}
    orderedSongs.each {|song| 
      puts "#{x}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
      x = x + 1
    }
  end
  
  def list_artists
    x = 1
    orderedArtists = Artist.all.sort {|a,b| a.name <=> b.name}
    orderedArtists.each {|artist|
      puts "#{x}. #{artist.name}"
      x = x + 1
    }
  end
  
  def list_genres
    x = 1
    orderedGenres = Genre.all.sort {|a,b| a.name <=> b.name}
    orderedGenres.each do |g| 
      puts "#{x}. #{g.name}"
      x = x + 1
    end
  end
      
  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    input = gets.strip
    
    x = 1
    artist = Artist.all.find {|a| a.name == input}
    songs = Song.all.select {|song| artist == song.artist} 
    sortedSongs = songs.sort {|a,b| a.name <=> b.name}
    sortedSongs.each {|s|
      puts "#{x}. #{s.name} - #{s.genre.name}"
      x = x + 1
    }
  end
  
  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    genre = gets.strip 
        
    songs = Song.all.select {|song| song.genre.name == genre}
    orderedSongs = songs.sort {|a,b| a.name <=> b.name}
    
    x = 1
    orderedSongs.each do |s| 
      puts "#{x}. #{s.artist.name} - #{s.name}"
      x = x + 1
    end
  end
  
  def play_song   
    puts "Which song number would you like to play?"
    # list_songs
    input = gets.strip.to_i
    if input > 0 && input < Song.all.length
    index = input - 1
      sortedSongs = Song.all.sort {|a,b| a.name <=> b.name}
      song = sortedSongs[index]
      puts "Playing #{song.name} by #{song.artist.name}"
    end
  end
end         