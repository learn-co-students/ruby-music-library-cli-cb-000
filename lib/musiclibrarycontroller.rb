class MusicLibraryController
attr_accessor :path




def initialize(path='./db/mp3s')
   @path = path
   MusicImporter.new(@path).import

 end

def call
  response = nil
  while response != "exit"
    response = gets.strip
    puts "Welcome to your music library!"
    puts "To list all of your songs, enter 'list songs'."
    puts "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the genres in your library, enter 'list genres'."
    puts "To list all of the songs by a particular artist, enter 'list artist'."
    puts "To list all of the songs of a particular genre, enter 'list genre'."
    puts "To play a song, enter 'play song'."
    puts "To quit, type 'exit'."
    puts "What would you like to do?"
    if response==='list songs'
      list_songs
  elsif response==='list artists'
     list_artists
  elsif response==='list genres'
     list_genres
elsif response==='list artist'
   list_songs_by_artist
elsif response==='list genre'
  list_songs_by_genre
elsif response==='play song'
  play_song
end

 end




end


def list_songs

   Song.all.sort{|a,b|a.name<=> b.name}.each_with_index do |value, index|
     puts "#{index+1}. #{value.artist.name} - #{value.name} - #{value.genre.name}"
   end
 end




def list_artists

   Song.all.sort{|a,b|a.name<=> b.name}.each_with_index do |value, index|
     puts "#{index+1}. #{value.artist.name}"
   end
 end



   def list_genres

      Song.all.sort{|a,b|a.name<=> b.name}.each_with_index do |value, index|
        puts "#{index+1}. #{value.genre.name}"
      end

    end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    response = gets.strip
    Song.all.select{|song|song.artist.name === response}.sort{|a,b|a.name<=> b.name}.each_with_index do |value, index|
      puts "#{index+1}. #{value.name} - #{value.genre.name}"
    end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    response = gets.strip
    Song.all.select{|song|song.genre.name === response}.sort{|a,b|a.name<=> b.name}.each_with_index do |value, index|
      puts "#{index+1}. #{value.artist.name} - #{value.name}"
    end
  end



  def play_song
    puts "Which song number would you like to play?"
    input = gets.strip.to_i

    if input >= 1 && input <= Song.all.count

      array = Song.all.sort{|a,b| a.name <=> b.name}
      s = array[(input - 1)]
     puts "Playing #{s.name} by #{s.artist.name}"
   end

  end
















end
