class MusicLibraryController
  attr_reader :path
  def initialize(path='./db/mp3s')
    @music_importer = MusicImporter.new(path)
    @music_importer.import
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
    loop do
      choice = gets
      if choice == "list songs"
        list_songs
      elsif choice == "list artists"
        list_artists
      elsif choice == "list genres"
        list_genres
      elsif choice == "list artist"
        list_songs_by_artist
      elsif choice == "list genre"
        list_songs_by_genre
      elsif choice == "play song"
        play_song
      end
      break if choice == "exit"
    end
  end
  def list_songs
    sorted_list = @music_importer.files.sort!{|a,b| a.name <=> b.name}
    sorted_list.each_with_index{|song, index| puts "#{index+1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"}
  end
  def list_artists
    uniq_artist = @music_importer.files.uniq!{|song| song.artist.name}
    sorted_list = uniq_artist.sort!{|a,b| a.artist.name <=> b.artist.name}
    sorted_list.each_with_index{|song, index| puts "#{index+1}. #{song.artist.name}"}
  end
  def list_genres
    uniq_genres = @music_importer.files.uniq!{|song| song.genre.name}
    sorted_list = uniq_genres.sort!{|a,b| a.genre.name <=> b.genre.name}
    sorted_list.each_with_index{|song, index| puts "#{index+1}. #{song.genre.name}"}
  end
  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    artist = gets
    songs = @music_importer.files.select{|song| song.artist.name == artist}
    sorted_list = songs.sort!{|a,b| a.name <=> b.name}
    sorted_list.each_with_index{|song, index| puts "#{index+1}. #{song.name} - #{song.genre.name}"}
  end
  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    genre = gets
    genre = @music_importer.files.select{|song| song.genre.name == genre}
    sorted_list = genre.sort!{|a,b| a.name <=> b.name}
    sorted_list.each_with_index{|song, index| puts "#{index+1}. #{song.artist.name} - #{song.name}"}
  end
  def play_song
    puts "Which song number would you like to play?"
    #list_songs
    choice = gets
    choice = choice.to_i
    if choice.is_a? Integer
      if (choice > 0) && (choice <= @music_importer.files.size)
         sorted_list = @music_importer.files.sort!{|a,b| a.name <=> b.name}
         puts "Playing #{sorted_list[choice-1].name} by #{sorted_list[choice-1].artist.name}"
         #puts "My Choice --> #{choice}"
       end
     end
  end
end
