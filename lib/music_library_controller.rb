require 'pry'
class MusicLibraryController

  attr_accessor :path, :selection, :songs, :artists, :genres

  def initialize(path = "./db/mp3s")
    @path = path
    MusicImporter.new(path).import
    @selection = ""
    @songs = Song.print_songs.map {|e| "#{e}" }
    @artists = Artist.print_artists.map {|e| "#{e}" }
    @genres = Genre.print_genres.map {|e| "#{e}" }

  end

  def call
    while @selection.downcase != "exit"
      #puts "Please select from the following options by entering the number and then pressing enter:"
      #puts "1.) List Songs in your library."
      #puts "2.) List all Artists in your library."
      #puts "3.) List all Genres in your library."
      #puts "4.) Play a song."
      #puts "5.) List all songs by a particular Artists in your library."
      #puts "6.) List all songs of a particular Genre from your library."
      #puts "To exit, type \'exit\'."
      STDOUT.flush
      @selection = gets.chomp
      #binding.pry
      case @selection

      when "list songs"
        self.songs.each.with_index {|ele, ind| puts "#{ind + 1}. #{ele}"}
      when "list artists"
        self.artists.each {|e| puts "#{e}"}
      when "list genres"
        self.genres.each {|e| puts "#{e}"}
      when "play song"
        #puts "Please enter the number of the song you'd like to play."
        num = gets.chomp.to_i
        #binding.pry
        puts "Playing #{self.songs[num - 1]}"
      when "list artist"
        aarr = []
        artist = gets.chomp
        aarr = self.songs.select {|e| e.split(" - ")[0] == artist}
        aarr.each {|i| puts "#{i}"}
      when "list genre"
        garr = []
        genre = gets.chomp
        garr = self.songs.select {|e| e.split(" - ")[2] == genre}
        garr.each {|i| puts "#{i}"}
      when "exit"
        @selection = "exit"
      else
        puts "Invalid input. Please re-enter your selection."
      end

    end
  end

end
