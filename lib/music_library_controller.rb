class MusicLibraryController
  def initialize(path = "./db/mp3s")
    @importer = MusicImporter.new(path)
    @importer.import
  end

  def call
    loop do
      input = gets.chomp
      if input == "list songs"
        @importer.files.sort.each_with_index {|f, i| puts "#{i + 1}. #{f.split(".mp3")[0]}"}
      elsif input == "list artists"
        Artist.all.each {|a| puts "#{a.name}"}
      elsif input == "list genres"
        Genre.all.each {|g| puts "#{g.name}"}
      elsif input == "play song"
        puts "Which song number would you like to play?"
        song_number = gets.chomp.to_i - 1
        puts "Playing #{Song.all[song_number].artist.name} - #{Song.all[song_number].name} - #{Song.all[song_number].genre.name}"
      elsif input == "list artist"
        puts "Which artist would you like to listen to?"
        artist_request = gets.chomp
        Artist.find_by_name(artist_request).songs.each {|s| puts "#{s.artist.name} - #{s.name} - #{s.genre.name}"}
      elsif input == "list genre"
        puts "Which genre would you like to listen to?"
        genre_request = gets.chomp
        Genre.find_by_name(genre_request).songs.each {|s| puts "#{s.artist.name} - #{s.name} - #{s.genre.name}"}
      elsif input == "exit"
        break
      end
    end
  end
end
