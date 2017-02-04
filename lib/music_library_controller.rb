class MusicLibraryController

  def initialize(path='./db/mp3s')
    importer = MusicImporter.new(path)
    importer.import
  end

  def call
    puts "Welcome to Music Library"
    loop do 
      puts "What would you like to do?\n"
      input = gets.chomp
      case input
      when "list songs", "1"
        Song.print_all
      when "list artists", "2"
        Artist.print_all
      when "list genres", "3"
        Genre.print_all
      when "play song", "4"
        puts "Please enter song number"
        song_number = gets.chomp.to_i-1
        Song.play_song(song_number)
      when "list artist", "5"
        puts "Please enter an artist"
        artist = gets.chomp
        Artist.list_artist(artist)
      when "list genre", "6"
        puts "Please enter a genre"
        genre = gets.chomp
        Genre.list_genre(genre)
      when "exit"
        break
      else
        puts "Invalid command"
      end
    end
  end

end