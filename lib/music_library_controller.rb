class MusicLibraryController

  def initialize(path='./db/mp3s')
    @importer = MusicImporter.new(path)
    @importer.import
  end

  def call
    loop do
      input = gets.chomp
      if input == "list songs"
        @importer.files.sort.each_with_index do |file, i|
          puts "#{i + 1}. #{file.split(".mp3")[0]}"
        end
      elsif input == "list artists"
        Artist.all.each {|artist| puts artist.name}
      elsif input == "list genres"
        Genre.all.each {|genre| puts genre.name}
      elsif input == "play song"
        puts "Which song?"
        song_num = gets.chomp
        puts "Playing #{@importer.files.sort[song_num.to_i - 1]}"
      elsif input == "list artist"
        puts "Which artist?"
        artist_name = gets.chomp
        artist = Artist.find_by_name(artist_name)
        artist.songs.each do |song|
          puts "#{song.artist.name} - #{song.name} - #{song.genre.name}"
        end
      elsif input == "list genre"
        puts "Which genre?"
        genre_name = gets.chomp
        genre = Genre.find_by_name(genre_name)
        genre.songs.each do |song|
          puts "#{song.artist.name} - #{song.name} - #{song.genre.name}"
        end
      end
      break if input == "exit"
    end
  end
end
