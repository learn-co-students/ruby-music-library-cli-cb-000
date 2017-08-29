# implements interface to music library
class MusicLibraryController

  @music_importer
  @library = []

  def initialize(path = './db/mp3s')
    music_importer = MusicImporter.new(path)
    @library = music_importer.import
  end

def call(action = '')
    until action == 'exit' do
      puts %{Welcome to your music library!}
      puts %{To list all of your songs, enter 'list songs'.}
      puts %{To list all of the artists in your library, enter 'list artists'.}
      puts %{To list all of the genres in your library, enter 'list genres'.}
      puts %{To list all of the songs by a particular artist, enter 'list artist'.}
      puts %{To list all of the songs of a particular genre, enter 'list genre'.}
      puts %{To play a song, enter 'play song'.}
      puts %{To quit, type 'exit'.}
      puts %{What would you like to do?}

      action = gets.strip
      case action
        when "list songs"
          list_songs
        when "list artists"
          list_artists
        when "list genres"
          list_genres
        when "list artist"
          list_songs_by_artist
        when "list genre"
          list_songs_by_genre
        when "play song"
          play_song
      end
    end
  end

  def list_songs
    array =  Song.all.sort_by(&:name)
    array.each_with_index do |obj, ind|
      puts "#{ind + 1}. #{obj}"
    end
  end

  def list_songs_by_artist
    puts 'Please enter the name of an artist:'
    artist_name = gets
      if artist = Artist.find_by_name(artist_name)
        artist.songs.sort.each_with_index do |song, index|
        puts "#{index+1}. #{song.name} - #{song.genre.name}"
      end
    end
  end


  def list_songs_by_genre
    puts 'Please enter the name of a genre:'
    genre_name = gets
      if genre = Genre.find_by_name(genre_name)
        genre.songs.sort.each_with_index do |song, index|
          puts "#{index+1}. #{song.artist.name} - #{song.name}"
        end
    end
  end

  def play_song
    puts "Which song number would you like to play?"
    song_number = gets.strip.to_i
    if (song_number > 0 && song_number < Song.all.length)
      song = Song.all.sort[song_number - 1]
    end
    puts "Playing #{song.name} by #{song.artist.name}" if song
  end

  def list_artists
    array  = Artist.all.sort_by(&:name)
    array.each_with_index do |obj, ind|
      puts "#{ind + 1}. #{obj}"
    end
  end

  def list_genres
    list_array Genre.all.sort_by(&:name)
  end

  def list_array(list)
    list.each_with_index  do |obj, ind|
      puts "#{ind + 1}. #{obj}"
    end
  end
end

