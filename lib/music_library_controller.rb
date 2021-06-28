require 'pry'

class MusicLibraryController
  attr_accessor :music_importer

  def initialize(path='./db/mp3s')
    @music_importer = MusicImporter.new(path)
    @music_importer.import
  end

  def call
    puts 'Welcome to your music library!'
    puts "To list all of your songs, enter 'list songs'."
    puts "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the genres in your library, enter 'list genres'."
    puts "To list all of the songs by a particular artist, enter 'list artist'."
    puts "To list all of the songs of a particular genre, enter 'list genre'."
    puts "To play a song, enter 'play song'."
    puts "To quit, type 'exit'."
    puts "What would you like to do?"
    input = gets.chomp
    case input
    when "list songs"
      self.list_songs
    when "list artists"
      self.list_artists
    when "list genres"
      self.list_genres
    when "list artist"
      self.list_songs_by_artist
    when "list genre"
      self.list_songs_by_genre
    when "play song"
      self.play_song
    when "exit"
      exit
    else
      self.call
    end
  end

  def list_songs
    Song.all.sort_by {|obj| obj.name}.each_with_index {|song, idx| puts "#{idx+1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"}
  end

  def list_artists
    Artist.all.sort_by {|obj| obj.name}.each_with_index {|artist, idx| puts "#{idx+1}. #{artist.name}"}
  end

  def list_genres
    Genre.all.sort_by {|obj| obj.name}.each_with_index {|genre, idx| puts "#{idx+1}. #{genre.name}"}
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    artist = gets.chomp
    finder = Artist.find_by_name(artist)
    finder.songs.sort_by {|obj| obj.name}.each_with_index {|obj, idx| puts "#{idx+1}. #{obj.name} - #{obj.genre.name}"} if !finder.nil?
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    genre = gets.chomp
    finder = Genre.find_by_name(genre)
    finder.songs.sort_by {|obj| obj.name}.each_with_index {|obj, idx| puts "#{idx+1}. #{obj.artist.name} - #{obj.name}"} if !finder.nil?
  end

  def play_song
    puts "Which song number would you like to play?"
    idx = gets.to_i
    if idx > 0
      song = Song.all.sort_by {|obj| obj.name}[idx-1]
      puts "Playing #{song.name} by #{song.artist.name}" if !song.nil?
    end
  end
end
