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
    input = nil
    until input == 'exit'
      input = gets.chomp
      if input == 'list songs'
        list_songs
      elsif input == 'list artists'
        list_artists
      elsif input == 'list genres'
        list_genres
      elsif input == 'list artist'
        list_songs_by_artist
      elsif input == 'list genre'
        list_songs_by_genre
      elsif input == 'play song'
        play_song
      end
    end

  end

  def list_songs
    songs = Song.all.sort_by { |s| s.name }
    songs.each do |n|
        puts "#{(songs.index(n)) + 1}. #{n.artist.name.split('/')[-1]} - #{n.name} - #{n.genre.name}"
    end
  end

  def list_artists
    items = Artist.all.sort_by { |i| i.name }
    items.each do |n|
        puts "#{(items.index(n)) + 1}. #{n.name.split('/')[-1]}"
    end
  end

  def list_genres
    items = Genre.all.sort_by { |i| i.name }
    items.each do |n|
        puts "#{(items.index(n)) + 1}. #{n.name.split('/')[-1]}"
    end
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    artist = gets.chomp
    found = Artist.find_or_create_by_name(artist)
    songs = found.songs.sort_by { |s| s.name }
    songs.each do |n|
        puts "#{(songs.index(n)) + 1}. #{n.name} - #{n.genre.name}"
    end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    genre = gets.chomp
    found = Genre.find_or_create_by_name(genre)
    songs = found.songs.sort_by { |s| s.name }
    songs.each do |n|
        puts "#{(songs.index(n)) + 1}. #{n.artist.name.split('/')[-1]} - #{n.name}"
    end
  end

  def play_song
    puts "Which song number would you like to play?"
    song_number = gets.chomp.to_i
    songs = Song.all.sort_by { |s| s.name }
    if song_number > 1 && songs[song_number - 1]
      puts "Playing #{songs[song_number - 1].name} by #{songs[song_number - 1].artist.name}"
    end
  end

end
