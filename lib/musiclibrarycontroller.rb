class MusicLibraryController
  attr_accessor :path
  
  def initialize(path = "./db/mp3s")
    @path = path
    MusicImporter.new(path).import
  end

  def call
    loop do 
      user_input = gets.chomp

      case user_input
          
      when "exit"
        break
        
      when "list songs"
        
        songs_list  = Song.all.collect do |song|
          "#{song.artist.name} - #{song.name} - #{song.genre.name}"
        end
        songs_list.sort.each_with_index {|song_name, i| puts "#{i+1}. #{song_name}"}
        
      when "list artists"
        Artist.all.each {|artist| puts artist.name}
        
      when "list genres"
        Genre.all.each {|genre| puts genre.name}
        
      when  "play song"
        song_no = gets.chomp
        songs_list  = Song.all.collect do |song, i|
          "#{song.artist.name} - #{song.name} - #{song.genre.name}"
        end
        songs_list.sort.each_with_index do |song_name, i|
          puts "Playing #{song_name}" if song_no.to_i == i + 1
        end
        
      when  "list artist"
        artist_name = gets.chomp 
        Artist.all.each do |artist|
          if artist_name == artist.name
            artist.songs.each do |song|
               puts "#{song.artist.name} - #{song.name} - #{song.genre.name}"
            end
          end
        end

      when "list genre"
        
        genre_name = gets.chomp 
        Genre.all.each do |genre|
          if genre_name == genre.name
            genre.songs.each do |song|
              puts "#{song.artist.name} - #{song.name} - #{song.genre.name}"
            end
          end
        end
        

      end

    end
  
  end

end
