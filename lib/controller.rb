class MusicLibraryController
  attr_accessor :path, :import

  def initialize(path = "./db/mp3s")
    @path = path
    @import = MusicImporter.new(@path).import
  end

  def call
    puts "What do you want? (exit to end)"
    input = ""
    while input != "exit"
      input = gets

      case input
      when "exit"
        break
      when  "list songs"
        sorted = @import.sort { |a,b|
            a.artist.name <=> b.artist.name
        }
        sorted.each { |song|
          puts "#{sorted.index(song) + 1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
        }
      when "list artists"
        @import.each { |song|
          puts "#{song.artist.name}"
        }
      when "list genres"
        @import.each { |song|
          puts "#{song.genre.name}"
        }
      when "play song"
        i = gets
        song = @import[i.to_i - 1]
        puts "Playing #{song.artist.name} - #{song.name} - #{song.genre.name}"
      when "list artist"
        artist = gets
        songs = @import.select { |song| song.artist.name == artist}
        songs.each {|song| puts "#{song.artist.name} - #{song.name} - #{song.genre.name}"}
      when "list genre"
        genre = gets
        songs = @import.select { |song| song.genre.name == genre}
        songs.each {|song| puts "#{song.artist.name} - #{song.name} - #{song.genre.name}"}
      end
    end
  end

end
