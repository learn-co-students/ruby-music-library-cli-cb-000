class MusicLibraryControllerError < StandardError
end

class MusicLibraryController
  def initialize(path=nil)
    path ||= './db/mp3s'
    importer = MusicImporter.new(path)
    importer.import
  end

  def call
    loop do
      input = gets.chomp
      cmd = "do_#{input.gsub(' ', '_')}".to_sym
      begin
        self.send(cmd)
      rescue MusicLibraryControllerError
        break
      rescue ArgumentError, NoMethodError
        puts "Invalid Command: #{input}"
      end
    end
  end

  # Helper Methods
  def list_songs
    idx = 1
    songs = Song.all.sort_by {|s| s.artist.name.upcase}
    songs.each do |s|
      puts "#{idx}. #{s}"
      idx += 1
    end
  end

  def list_artists
    artists = Artist.all.sort_by {|a| a.name}
    artists.each do |a|
      puts a
    end
  end

  def list_genres
    genres = Genre.all.sort_by {|g| g.name}
    genres.each do |g|
      puts g
    end
  end

  # Command Methods
  def do_play_song
    puts "Enter song number you would like to play:"
    songs = self.list_songs
    song_number = gets.chomp.to_i
    song = songs[song_number - 1]
    puts "Playing #{song}"
  end

  def do_list_artist
    puts "Which artist would you like to list?"
    self.list_artists
    artist_name = gets.chomp
    artist = Artist.find_by_name(artist_name)
    artist.songs.each do |s|
      puts s
    end
  end

  def do_list_genre
    puts "Which genre would you like to list?"
    self.list_genres
    genre_name = gets.chomp
    genre = Genre.find_by_name(genre_name)
    genre.songs.each do |s|
      puts s
    end
  end

  def do_list_songs
    self.list_songs
  end
  def do_list_genres
    self.list_genres
  end
  def do_list_artists
    self.list_artists
  end
  def do_exit
    raise MusicLibraryControllerError
  end
end
