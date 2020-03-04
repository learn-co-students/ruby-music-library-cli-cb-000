class MusicLibraryController
  attr_accessor :path

  def initialize(path = './db/mp3s')
    @path = MusicImporter.new(path).import

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
  input = gets.chomp

  until input == 'exit'

    if input == 'list songs'
      list_songs
      # input = 'exit'
      break
    elsif input == 'list artists'
      list_artists
      break
    elsif input == 'list genres'
      list_genres
      break
    elsif input == 'list artist'
      list_songs_by_artist
      break
    elsif input == 'list genre'
      list_songs_by_genre
      break
    elsif input == 'play song'
      play_song
      break
    else
      input = gets.chomp
    end
  end
end

def list_songs
  # puts Song.a
  # puts Song.all.class
  # sorted = Song.all.sort
  sorted = Song.all.sort_by {|obj| obj.name}
  # puts sorted
  sorted.each_with_index do |song, i|
    # wtf!!!!
    puts "#{i+1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
  end
end

def list_artists
  sorted = Artist.all.sort_by {|obj| obj.name}
  sorted.each_with_index do |artist, i|
    puts "#{i+1}. #{artist.name}"
  end
end

def list_genres
  sorted = Genre.all.sort_by {|obj| obj.name}
  sorted.each_with_index do |genre, i|
    puts "#{i+1}. #{genre.name}"
  end
end

def list_songs_by_artist
  puts "Please enter the name of an artist:"
  input = gets.chomp

  # p input
  # how to get the songs tied to an artist?
  # not a class... not in the beginning at least.

  # i guess making sure its a class makes sense. wouldve been nice to been told...
  # a test that says - if artist is not found, nothing happens
  if Artist.find_by_name(input).instance_of? Artist
    sorted = Artist.find_by_name(input).songs.sort_by {|obj| obj.name}
    sorted.each_with_index do |song, i|
      puts "#{i+1}. #{song.name} - #{song.genre.name}"
    end
  end
end

def list_songs_by_genre
  puts "Please enter the name of a genre:"
  input = gets.chomp

  if Genre.find_by_name(input).instance_of? Genre
    sorted = Genre.find_by_name(input).songs.sort_by {|obj| obj.name}
    sorted.each_with_index do |song, i|
      puts "#{i+1}. #{song.artist.name} - #{song.name}"
    end
  end
end

def play_song
  puts "Which song number would you like to play?"
  input = gets.chomp

  # not seeing the point of this test.

  sorted = Song.all.sort_by {|obj| obj.name}

  if sorted[input.to_i-1].instance_of? Song and (input.to_i < Song.all.size and input.to_i >= 1)

  puts "Playing #{sorted[input.to_i-1].name} by #{sorted[input.to_i-1].artist.name}"
end

end
end
