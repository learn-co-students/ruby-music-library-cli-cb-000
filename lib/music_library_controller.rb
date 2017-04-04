class MusicLibraryController


def initialize(path = './db/mp3s')
  @path = path
  music_importer = MusicImporter.new(path)
  @music = []
  @music = music_importer.import
end

def call
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
  @music.sort.each.with_index(1) do |s, i|

    puts "#{i}. #{s}"
  end
end

def artists
  @music.sort.each.with_index(1) do |s, i|
    s = s.split(" - ")
    puts "#{i}. #{s[0]}"
  end
end

def list_artist
  input = gets.strip
  @music.sort.each.with_index(1) do |s, i|
    x = s.split(" - ")
    puts "#{s}" if input == x[0]
  end
end

def list_genre
  input = gets.strip
  @music.sort.each.with_index(1) do |s, i|
    x = s.split(" - ")
    genre = x[2].split(".")
    puts "#{s}" if input == genre[0]
  end
end

def genres
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
