class MusicLibraryController

  def initialize(path="./db/mp3s")
    importer = MusicImporter.new(path)
    importer.import
  end

  def call
    input = ""
    while input != "exit" do
        puts "What are you looking for?"
       input = gets.chomp

       if input == "list songs"
         Song.all.each_with_index {|val, index| puts " #{index+1}. #{val.artist.name} - #{val.name} - #{val.genre.name}"}
       elsif input == "list artists"
         Artist.all.each {|artist| puts "#{artist.name}"}
       elsif input == "list genres"
         Genre.all.each {|genre| puts "#{genre.name}"}
       elsif input == "play song"
         puts "What song number can I play for you?"
         index_song_request = gets.chomp.to_i - 1
         puts "Playing #{Song.all[index_song_request].artist.name} - #{Song.all[index_song_request].name} - #{Song.all[index_song_request].genre.name}"
       elsif input == "list artist"
         puts "What artist are you looking for?"
         request_artist = gets.chomp
         Artist.find_by_name(request_artist).songs.each {|song| puts "#{song.artist.name} - #{song.name} - #{song.genre.name}"}
       elsif input == "list genre"
         puts "What genre are you looking for?"
         request_genre = gets.chomp
         Genre.find_by_name(request_genre).songs.each {|song| puts "#{song.artist.name} - #{song.name} - #{song.genre.name}"}
       end
     end
   end
end
