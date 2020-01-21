class MusicLibraryController

  def initialize(path='./db/mp3s')
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
    if input == "list songs"
      self.list_songs
    elsif input == "list artists"
      self.list_artists
    elsif input == "list genres"
      self.list_genres
    elsif input == "list artist"
      self.list_songs_by_artist
    elsif input == "list genre"
      self.list_songs_by_genre
    elsif input == "play song"
      self.play_song
    elsif input != "exit"
      self.call
    end
  end

  def list_songs
    list = []
    Song.all.each {|song| list << "#{song.artist.name} - #{song.name} - #{song.genre.name}"}
    list.sort! {|item, nextItem| item.split(' - ')[1] <=> nextItem.split(' - ')[1]}
    list.each_with_index {|item, index| puts "#{index + 1}. #{item}"}
  end

  def list_artists
    list = []
    Artist.all.each {|artist| list << artist.name if list.include?(artist.name) == false}
    list.sort.each_with_index{|item, index| puts "#{index + 1}. #{item}"}
  end

  def list_genres
    list = []
    Genre.all.each {|genre| list << genre.name if list.include?(genre.name) == false}
    list.sort.each_with_index{|item, index| puts "#{index + 1}. #{item}"}
  end


  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    input = gets.strip
    Artist.all.any?{|item| item.name == input} ? artist = Artist.find_by_name(input) : artist = nil
    if artist != nil
      artist.songs.sort! {|song, nextSong| song.name <=> nextSong.name}
      artist.songs.each_with_index {|song, index| puts "#{index+1}. #{song.name} - #{song.genre.name}"}
    end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    input = gets.strip
    Genre.all.any?{|item| item.name == input} ? genre = Genre.find_by_name(input) : genre = nil
    if genre != nil
      genre.songs.sort! {|song, nextSong| song.name <=> nextSong.name}
      genre.songs.each_with_index {|song, index| puts "#{index+1}. #{song.artist.name} - #{song.name}"}
    end
  end

  def play_song
    puts "Which song number would you like to play?"
    input = gets.strip.to_i
    list = []
    Song.all.each {|song| list << "#{song.artist.name} - #{song.name} - #{song.genre.name}"}
    list.sort! {|item, nextItem| item.split(' - ')[1] <=> nextItem.split(' - ')[1]}
    if input <= list.length && input >= 1
      song = list[input - 1].split(" - ")[1]
      artist = list[input - 1].split(" - ")[0]
      puts "Playing #{song} by #{artist}"
    end
  end

end
