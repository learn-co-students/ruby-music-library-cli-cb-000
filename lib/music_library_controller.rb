class MusicLibraryControllerError < StandardError
end

class MusicLibraryController
  attr_reader :path, :importer
  def initialize(path='./db/mp3s')
    @path = path
    @importer = MusicImporter.new(path)
    @importer.import
  end

  def call
    loop do
      input = gets.chomp
      cmd = input.gsub(' ', '_')
      begin
        self.send(cmd)
      rescue MusicLibraryControllerError
        break
      rescue ArgumentError, NoMethodError
        puts "Invalid Command: #{input}"
      end
    end
  end

  def exit
    raise MusicLibraryControllerError
  end

  def list_songs
    idx = 1
    songs = Song.all.sort_by {|s| s.artist.name.upcase}
    songs.each do |s|
      puts "#{idx}. #{s.display}"
      idx += 1
    end
  end

  def list_artists
    artists = Artist.all.sort_by {|a| a.name.upcase}
    artists.each do |a|
      puts a.name
    end
  end

  def list_genres
    genres = Genre.all.sort_by {|g| g.name.upcase}
    genres.each do |g|
      puts g.name
    end
  end

  def play_song
    puts "Enter song number you would like to play:"
    songs = self.list_songs
    song_number = gets.chomp.to_i
    song = songs[song_number - 1]
    puts "Playing #{song.display}"
  end

  def list_artist
    puts "Which artist would you like to list?"
    list_artists
    artist_name = gets.chomp
    artist = Artist.find_by_name(artist_name)
    artist.songs.each do |s|
      puts s.display
    end
  end

  def list_genres
    genres = Genre.all.sort_by {|g| g.name.upcase}
    genres.each do |g|
      puts "#{g.name}"
    end
  end
  
  def list_genre
    puts "Which genre would you like to list?"
    list_genres
    genre_name = gets.chomp
    genre = Genre.find_by_name(genre_name)
    genre.songs.each do |s|
      puts s.display
    end
  end

end
