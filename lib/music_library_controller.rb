class MusicLibraryController
  attr_accessor :songs

  def initialize(path = "./db/mp3s")
    music_importer = MusicImporter.new(path)
    @songs = music_importer.import
  end

  def call
    exit_boolean = false

    while exit_boolean != true
      print "Please enter a command: list songs, list genres, play song, list artist, list genre, or exit"
      input = gets.chomp

      case input
      when "list songs"
        Song.print_with_index
      when "list artists"
        Artist.print_artists
      when "list genres"
        Genre.print_genres
      when "play song"
        print "Which song number would you like to play?"
        song = Song.all[gets.chomp.to_i - 1]
        puts "Playing #{Song.print_song(song)}"
      when "list artist"
        print "Which artist's songs would you like to list?"
        artist = gets.chomp
        songs = Song.all.select { |song| song.artist.name == artist }
        songs.each { |song| puts Song.print_song(song) }
      when "list genre"
        print "Which genre would you like to list songs for?"
        genre = gets.chomp
        songs = Song.all.select { |song| song.genre.name == genre }
        songs.each { |song| puts Song.print_song(song) }
      when "exit"
        exit_boolean = true
      end
    end

  end
end
