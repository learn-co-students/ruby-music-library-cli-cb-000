class MusicLibraryController

  attr_accessor :input

  def initialize(path='./db/mp3s')
    music_importer = MusicImporter.new(path)
    music_importer.import
    @input = ""
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

    while self.input != 'exit'
      self.input = gets

      case input
        when 'list songs'
          list_songs
        when 'list genres'
          list_genres
        when 'list artist'
          list_artist
        when 'play song'
          play_song
        when 'list genre'
          list_songs_by_genre
        when 'list artists'
          list_artists
      end
    end
  end

  def list_songs
    arr1 = Song.all.collect {|song| song.name}.sort
    arr2 = arr1.collect do |name|
            "#{Song.find_by_name(name).artist.name} - #{name} - #{Song.find_by_name(name).genre.name}"
          end

    arr2.each_with_index do |item, index|
      puts "#{index + 1}. #{item}"
    end
  end

  def list_artists
    arr1 = Artist.all.collect {|artist| artist.name}.uniq.sort

    arr1.each_with_index do |item, index|
      puts "#{index + 1}. #{item}"
    end
  end

  def list_genres
    arr1 = Genre.all.collect {|genre| genre.name}.uniq.sort

    arr1.each_with_index do |item, index|
      puts "#{index + 1}. #{item}"
    end
  end

  def list_songs_by_artist
    input = ""
      puts "Please enter the name of an artist:"
      input = gets
      if artist = Artist.find_by_name(input) != nil
        artist = Artist.find_by_name(input)
        artist.songs = artist.songs.sort_by {|song| song.name}
        artist.songs.each_with_index do |item, index|
          puts "#{index + 1}. #{item.name} - #{item.genre.name}"
        end
      end
  end

  def list_songs_by_genre
    input = ""
      puts "Please enter the name of a genre:"
      input = gets
      if genre = Genre.find_by_name(input) != nil
        genre = Genre.find_by_name(input)
        genre.songs = genre.songs.sort_by {|song| song.name}
        genre.songs.each_with_index do |item, index|
          puts "#{index + 1}. #{item.artist.name} - #{item.name}"
        end
      end
  end

  def play_song
    input = ''
    puts "Which song number would you like to play?"
      input = gets
      input = input.to_i
      if input > 0 && input <= Song.all.length
        arr1 = Song.all.sort_by {|song| song.name}
        puts "Playing #{arr1[input - 1].name} by #{arr1[input -1 ].artist.name}"
      end
  end

  def list_artist
    list_songs_by_artist
  end


end
