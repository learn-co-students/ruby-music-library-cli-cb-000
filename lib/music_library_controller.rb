class MusicLibraryController

  attr_reader :path

  def initialize(path='./db/mp3s')
    @path=path
    #@new_music=MusicImporter.new(path)
    #@new_music.import
    MusicImporter.new(path).import

    #new_music=MusicImporter.new(path)
    #new_music.import

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
    #puts "What would you like to do?"

    input=""#gets.strip

    while input!="exit"
      puts "What would you like to do?"

      input=gets.strip

      if input=="list songs"
        list_songs
        #:list_songs
        #@new_music.list_songs
      elsif input=="list artists"
        list_artists
      elsif input=="list genres"
        list_genres
      elsif input=="list artist"
        list_songs_by_artist
      elsif input=="list genre"
        list_songs_by_genre
      elsif input=="play song"
        play_song
      end
    end
  end

  def list_songs
    #@songs.each {|song| puts song.name}
    song_array=Song.all
    song_array.sort_by!{|song| song.name}
    #Song.all.each_with_index do |song,index|
    song_array.each_with_index do |song,index|
      puts "#{index+1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    end
  end

  def list_artists
    artist_array=Artist.all
    artist_array.sort_by!{|artist| artist.name}
    artist_array.each_with_index do |artist,index|
      puts "#{index+1}. #{artist.name}"
    end
  end

  def list_genres
    genre_array=Genre.all
    genre_array.sort_by!{|genre| genre.name}
    genre_array.each_with_index do |genre,index|
      puts "#{index+1}. #{genre.name}"
    end
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    input=gets.strip

    #song_array=Artist.songs

    song_array=Song.all.select{|song|song.artist.name==input}
    #song_array=song_array.select{|song|song.artist==input}
    song_array.sort_by!{|song| song.name}
    song_array.each_with_index do |song,index|
      puts "#{index+1}. #{song.name} - #{song.genre.name}"
    end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    input=gets.strip

    genre_array=Song.all.select{|song|song.genre.name==input}
    genre_array.sort_by!{|song| song.name}
    genre_array.each_with_index do |song,index|
      puts "#{index+1}. #{song.artist.name} - #{song.name}"
    end
  end

  def play_song
    #list_songs
    song_array=Song.all
    song_array.sort_by!{|song| song.name}

    puts "Which song number would you like to play?"
    input=gets.strip.to_i

    if input>0 && input<song_array.length
      puts "Playing #{song_array[input-1].name} by #{song_array[input-1].artist.name}"
    end

    #if input>0 && input<Song.all.length
      #puts "Playing #{Song.all[input-1].name} by #{Song.all[input-1].artist.name}"
    #end
  end

  #list_songs

end

#MusicLibraryController.new.call

#MusicLibraryController.list_songs
