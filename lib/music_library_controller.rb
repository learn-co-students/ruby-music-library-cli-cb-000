class MusicLibraryController
  attr_reader :files

  def initialize(path = './db/mp3s')
    @files = MusicImporter.new(path).import
  end

  def call
    input = ''
    while input != 'exit'
      puts "Welcome to your music library!"
      puts "To list all of your songs, enter 'list songs'."
      puts "To list all of the artists in your library, enter 'list artists'."
      puts "To list all of the genres in your library, enter 'list genres'."
      puts "To list all of the songs by a particular artist, enter 'list artist'."
      puts "To list all of the songs of a particular genre, enter 'list genre'."
      puts "To play a song, enter 'play song'."
      puts "To quit, type 'exit'."
      puts "What would you like to do?"
      input = gets.chomp

      case input
      when 'list songs'
        self.list_songs
      when  'list artists'
        self.list_artists
      when 'list genres'
        self.list_genres
      when 'list artist'
        self.list_songs_by_artist
      when 'list genre'
        self.list_songs_by_genre
      when 'play song'
        self.play_song
      when 'exit'
        input = 'exit'            
      end
    end
  end

  def list_songs
    sort_by_name(Song.all).each_with_index {|song, i| puts "#{i + 1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"}
  end

  def list_artists
    list_by_name(sort_by_name(Artist.all))
  end

  def list_genres
    list_by_name(sort_by_name(Genre.all))
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    input = gets.chomp
    # search  for a matching artist, if successful, print all songs alphbetically
    match = Artist.all.detect {|artist| artist.name == input}
    if match
      sort_by_name(match.songs).each_with_index {|song, i| puts "#{i + 1}. #{song.name} - #{song.genre.name}"}
    end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    input = gets.chomp
    # search for a matching genre, if successful, pring all songs alphbetically
    match = Genre.all.detect {|genre| genre.name == input}
    if match
      sort_by_name(match.songs).each_with_index {|song, i| puts "#{i + 1}. #{song.artist.name} - #{song.name}"}
    end
  end

  def play_song
    puts "Which song number would you like to play?"
    input = gets.chomp.to_i #convert string to int
    match = nil
    # capture input, iterate through song array looking for the matching index, and corresponding song
    sort_by_name(Song.all).each_with_index do |song, i|
      if input == (i + 1)
        match = song
      end
    end
    puts "Playing #{match.name} by #{match.artist.name}" if match
  end

  private
  def sort_by_name(items)
    items.sort {|item1, item2| item1.name <=> item2.name}
  end

  def list_by_name(items)
    items.each_with_index {|item, i| puts "#{i + 1}. #{item.name}"}
  end

  # def list_songs
  #   sort_songs.each_with_index do |file, i|
  #     puts "#{i + 1}. #{file.gsub('.mp3', '')}"
  #   end
  # end
  #
  # def list_artists
  #   strip_and_sort_artists.each_with_index {|artist, i| puts "#{i + 1}. #{artist}"}
  # end
  #
  # private
  # # sort file names based on the song name, alphbetically
  # def sort_songs
  #   self.files.sort {|file1, file2| file1.split(' - ')[1]  <=> file2.split(' - ')[1]}
  # end
  #
  # # strip artist names from files, ensure they're unique and sort alphbetically
  # def strip_and_sort_artists
  #   self.files.collect {|file| file.split(' - ')[0]}.uniq.sort #{|a1, a2| a1 <=> a2}
  # end
end
