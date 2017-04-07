class MusicLibraryController


def initialize(path = './db/mp3s')
  @path = path
  music_importer = MusicImporter.new(path)
  @music = []
  @music = music_importer.import
end

def call
  puts "What would you like to do?"
  input = ""
  while input != "exit"

    input = gets.strip
    case input
    when "list songs"
      songs
    when "list artists"
      artists
    when "list genres"
      genres
    when "list artist"
      list_artist
    when "list genre"
      list_genre
    when "play song"
      play_song
    end
  end
end



def songs
  puts "The songs are: "
  @music.sort.each.with_index(1) do |s, i|

    puts "#{i}. #{s}"
  end
end

def artists
  puts "The artists are: "
  @music.sort.each.with_index(1) do |s, i|
    s = s.split(" - ")
    puts "#{i}. #{s[0]}"
  end
end

def list_artist
  puts "Who's songs are you looking for?"

  input = gets.strip
  puts "Here is a list of the songs by them."
  @music.sort.each.with_index(1) do |s, i|
    x = s.split(" - ")
    puts "#{s}" if input == x[0]
  end
end

def list_genre
  puts "What genres are you looking for?"

  input = gets.strip
  puts "Here is a list of songs in that genre."
  @music.sort.each.with_index(1) do |s, i|
    x = s.split(" - ")
    genre = x[2].split(".")
    puts "#{s}" if input == genre[0]
  end
end

def genres
  puts "The genres are: "
  @music.sort.each.with_index(1) do |s, i|
    s = s.split(" - ")
    puts "#{i}. #{s[2]}"
  end
end

def play_song
  array = []
  puts "What song would you like to play?"
  input = gets.strip
  input = input.to_i
  @music.sort.each.with_index(1) do |s, i|

    array <<  s
  end

  puts "Playing #{array[input - 1]}"
end

end
