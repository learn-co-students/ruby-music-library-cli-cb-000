class MusicLibraryController

  attr_accessor(:path)

  def initialize(path = "./db/mp3s")
    music_importer=MusicImporter.new(path)
    music_importer.import
  end

  def call
    puts "Welcome to your music library!"
    puts "To list all of your songs, enter \'list songs\'."
    puts "To list all of the artists in your library, enter \'list artists\'."
    puts "To list all of the genres in your library, enter \'list genres\'."
    puts "To list all of the songs by a particular artist, enter \'list artist\'."
    puts "To list all of the songs of a particular genre, enter \'list genre\'."
    puts "To play a song, enter \'play song\'."
    puts "To quit, type \'exit\'."
    puts "What would you like to do?"
    user_input=nil
    until user_input == "exit" do
      user_input=gets.chomp

      case user_input
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
      end

    end

  end

  def list_songs
    Song.all.sort_by{|song| song.name}.each_with_index { |song, index| puts "#{index+1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"}
  end

  def list_artists
    Artist.all.sort_by{|artist| artist.name }.each_with_index{ |artist, index| puts "#{index+1}. #{artist.name}"}
  end

  def list_genres
    Genre.all.sort_by{|genre| genre.name }.each_with_index{ |genre, index| puts "#{index+1}. #{genre.name}"}
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    artist_name=gets.chomp
    artist=Artist.find_or_create_by_name(artist_name)
    artists_songs=artist.songs
    artists_songs.sort_by{ |song| song.name }.each_with_index{ |song, index| puts "#{index+1}. #{song.name} - #{song.genre.name}"}
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    genre_name=gets.chomp
    genre=Genre.find_or_create_by_name(genre_name)
    genre_songs=genre.songs
    genre_songs.sort_by{ |song| song.name }.each_with_index{ |song, index| puts "#{index+1}. #{song.artist.name} - #{song.name}"}
  end

  def play_song
    #song_list=self.list_songs
    puts "Which song number would you like to play?"
    song_number=gets.chomp
    song_list=Song.all.sort_by{|song| song.name}
    if song_number.to_i <= song_list.size && song_number.to_i >= 1
      puts "Playing #{song_list[song_number.to_i-1].name} by #{song_list[song_number.to_i-1].artist.name}"
    else
    end
  end




end
