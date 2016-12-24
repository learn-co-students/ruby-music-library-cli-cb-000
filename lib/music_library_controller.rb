class MusicLibraryController

  def initialize(path = "./db/mp3s")
    MusicImporter.new(path).import
  end

  def call
    response = ""
    while response.downcase != "exit" do
      puts "What would you like to do?"
      response = gets.chomp
      if response.downcase == "help"
        puts "Commands:\nList Songs\nList Artists\nList Genres\nPlay Song"
      elsif response.downcase == "list songs"
        i = 0
        Song.all.sort{|a,b| a.artist.name.downcase <=> b.artist.name.downcase}.each do |song|
          i += 1
          puts "#{i}. #{song.artist.name} - #{song.name} - #{song.genre.name}\n"
        end
      elsif response.downcase == "list artists"
        puts "Input a specific artist to see all songs by that artist.\nOtherwise, put all to see a list of all artists."
        Artist.all.each do |artist|
          puts artist.name
        end
      elsif response.downcase == "list genres"
        Genre.all.each do |genre|
          puts genre.name
        end
      elsif response.downcase == "play song"
        puts "Which song would you like to hear?"
        choice = gets.chomp
        song = Song.all.sort{|a,b| a.artist.name.downcase <=> b.artist.name.downcase}[choice.to_i - 1]
        puts "Playing #{song.artist.name} - #{song.name} - #{song.genre.name}"
      elsif response.downcase == "list artist"
        puts "Which artist's songs would you like to see?"
        choice = gets.chomp
        Artist.find_by_name(choice).songs.each do |song|
          puts "#{song.artist.name} - #{song.name} - #{song.genre.name}"
        end
      elsif response.downcase == "list genre"
        puts "Which genre of songs would you like to see?"
        choice = gets.chomp
        Genre.find_by_name(choice).songs.each do |song|
          puts "#{song.artist.name} - #{song.name} - #{song.genre.name}"
        end
      end
    end
  end
end
