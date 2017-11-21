class MusicLibraryController

  def initialize(path="./db/mp3s")
      importer = MusicImporter.new(path)
      importer.import
    end

  def call
    input = ""
    puts  "Welcome to your music library!"
      until input == "exit"
    puts  "To list all of your songs, enter 'list songs'."
    puts  "To list all of the artists in your library, enter 'list artists'."
    puts  "To list all of the genres in your library, enter 'list genres'."
    puts  "To list all of the songs by a particular artist, enter 'list artist'."
    puts  "To list all of the songs of a particular genre, enter 'list genre'."
    puts  "To play a song, enter 'play song'."
    puts  "To quit, type 'exit'."
    puts  "What would you like to do?"

    input = gets.chomp

    case input
    when 'list songs'
      self.list_songs
    when 'list artists'
      self.list_artists
    when 'list genres'
      self.list_genres
    when 'list artist'
      self.list_songs_by_artist
    when 'list genre'
      self.list_songs_by_genre
    when 'play song'
      self.play_song
      end
    end
  end


def list_songs
  songs = Song.all.sort_by {|s| s.name}
  songs.each do |n|
    puts "#{(songs.index(n)) + 1}. #{n.artist.name.split('/')[-1]} - #{n.name} - #{n.genre.name}"
  end
end

def list_artists
  artists = Artist.all.sort_by {|art| art.name}
  artists.each do |n|
     puts "#{(artists.index(n)) + 1}. #{n.name.split('/')[-1]}"
  end
end

def list_genres
  gen = Genre.all.sort_by {|s| s.name}
  gen.each do |n|
    puts "#{(gen.index(n)) + 1}. #{n.name}"
  end
end

def list_songs_by_artist
  puts "Please enter the name of an artist:"
  input = gets.strip

  if artist = Artist.find_by_name(input)
    artist.songs.sort{ |a, b| a.name <=> b.name }.each.with_index(1) do |s, i|
    puts "#{i}. #{s.name} - #{s.genre.name}"
    end
  end
end

def list_songs_by_genre
  puts "Please enter the name of a genre:"
  input = gets.strip

  if genre = Genre.find_by_name(input)
    genre.songs.sort{ |a, b| a.name <=> b.name }.each.with_index(1) do |s, i|
    puts "#{i}. #{s.artist.name} - #{s.name}"
    end
  end
end

def play_song
  puts "Which song number would you like to play?"
    input = gets.strip.to_i - 1

    song = Song.all.sort {|a,b| a.name <=> b.name}[input]
    puts "Playing #{song.name} by #{song.artist.name}" if input < Song.all.length && input >= 0
end




end
