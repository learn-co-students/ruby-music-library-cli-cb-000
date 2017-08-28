class MusicLibraryController

  extend Concerns::Findable
  include Concerns::Findable

  def initialize( filepath = './db/mp3s')
    @filepath = filepath
    newMI = MusicImporter.new(filepath)
    newMI.import
  end

  def call

    user_input = ""
    while user_input != "exit"
      puts "Welcome to your music library!"
      puts "To list all of your songs, enter 'list songs'."
      puts "To list all of the artists in your library, enter 'list artists'."
      puts "To list all of the genres in your library, enter 'list genres'."
      puts("To list all of the songs by a particular artist, enter 'list artist'.")
      puts("To list all of the songs of a particular genre, enter 'list genre'.")
      puts("To play a song, enter 'play song'.")
      puts("To quit, type 'exit'.")
      puts("What would you like to do?")

      user_input = gets
      #print "User Entered:#{user_input}"

      case user_input
      when "list songs"
        list_songs
      when "list artists"
        list_artists
      when "list genres"
        list_genres
      when "list artist"
        list_songs_by_artist
      when "play song"
        play_song
      when "list genre"
        list_songs_by_genre
      end

    end # while user_input

  end # def call

  def list_songs
    Song.all.sort_by!{ |s| s.name.downcase }
    Song.all.each.with_index do |song, i|
      puts "#{i+1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    end
  end

  def list_artists
    Artist.all.sort_by!{ |a| a.name.downcase}
    Artist.all.each.with_index do |a, i|
      puts "#{i+1}. #{a.name}"
    end
  end

  def list_genres
    Genre.all.sort_by!{ |g| g.name.downcase}
    Genre.all.each.with_index do |g, i|
      puts "#{i+1}. #{g.name}"
    end
  end


  def list_songs_by_artist
    puts("Please enter the name of an artist:")
    user_input = gets.strip
    artistSongList = Artist.find_by_name( user_input )
    if artistSongList
      artistSongList.songs.sort_by!{ |s| s.name.downcase}
      artistSongList.songs.each.with_index { |song, i| puts"#{i+1}. #{song.name} - #{song.genre.name}"}
    end

  end

  def play_song
    puts "Which song number would you like to play?"
    user_input = gets.strip
    Song.all.sort_by!{ |s| s.name.downcase}
    if user_input.to_i > 0 && user_input.to_i < Song.all.size
      puts "Playing #{Song.all[user_input.to_i-1].name} by #{Song.all[user_input.to_i-1].artist.name}"
    end

  end

  def list_songs_by_genre
    puts"Please enter the name of a genre:"
    user_input = gets.strip
    genreSongs = Genre.find_by_name( user_input )
    if genreSongs
      genreSongs.songs.sort_by!{ |s| s.name.downcase}
      genreSongs.songs.each.with_index { |song, i| puts"#{i+1}. #{song.artist.name} - #{song.name}"}
    end

  end

end  #class MusicLibraryController
