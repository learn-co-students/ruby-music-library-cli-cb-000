require 'pry'

class MusicLibraryController
    attr_accessor :songs

  def initialize(path = './db/mp3s')
    music_importer = MusicImporter.new(path)
    @songs = music_importer.import
  end

  def call
    splash.each {|s| puts s}

    while true
      print "[CLIv1.0]  Please enter a command >>"
      command = gets.strip

      case command
      when "list songs", "1"
        Song.print_all_with_index
      when "list artists", "2"
        Artist.print_all
      when "list genres", "3"
        Genre.print_all
      when "play song", "4"
        #binding.pry
        print "[CLIv1.0]  Please enter a song # $$"
        song =  Song.all[gets.strip.to_i - 1]
        puts "Playing #{Song.printable(song)}"

      when "list artist", "5"
        print "[CLIv1.0]  Please enter an artist $$"
        artist = gets.strip
        songs = Song.all.select {|s| s.artist.name == artist}
        songs.each {|s| puts Song.printable(s)}

      when "list genre", "6"
        print "[CLIv1.0]  Please enter a genre $$"
        genre = gets.strip
        songs = Song.all.select {|s| s.genre.name == genre}
        songs.each {|s| puts Song.printable(s)}

      when "exit"
        break
      when "help"
        help.each {|h| puts h}
      else
        throw_error
      end
    end
  end

  private

  def splash
    splash = [""]
    splash << "$#{"-"*13}Welcome to Music Library CLI v1.0#{"-"*13}$"
    splash << File.read("./asset/splash")
    splash << "$#{"-"*59}$\n\n"
  end

  def help
    help = ["\nMusic CLI accepts the following commands:"]
    help << "<#> command"
    help << "1.  list songs"
    help << "2.  list artists"
    help << "3.  list genres"
    help << "4.  play song"
    help << "5.  list artist"
    help << "6.  list genre\n\n"
    help << "Enter the # or command\n\n"
  end

  def throw_error
    begin
      raise CLIError
    rescue CLIError => error
      puts error.message
    end
  end

  class CLIError < StandardError
    def message
      "!! Invalid! Type help for options !!\n\n"
    end
  end
end
