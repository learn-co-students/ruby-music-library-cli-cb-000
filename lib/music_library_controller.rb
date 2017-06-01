class MusicLibraryController
  attr_reader :path

  def initialize(path = "./db/mp3s")
    importer = MusicImporter.new(path)
    importer.import
  end

  def call
    input = ""
    greeting_done = false
    exit_commands = ["exit", "quit", "q", "x"]
    until exit_commands.include?(input)
      if !greeting_done
        puts "\nWelcome to the Music Library!\n"
        greeting_done = true
      else
        puts "\nYour command has been completed (see results above)!\n"
      end
      puts "Please enter one of the following commands:\n" +
          "  list songs\n  list artists\n  list genres\n  show artist\n  show genre\n  play song\n  exit"
      input = gets.strip
      case input
        when "list songs"
          list_songs
        when "list artists"
          list_artists
        when "list genres"
          list_genres
        when "show artist"
          show_artist
        when "show genre"
          show_genre
        when "play song"
          play_song
        else
          if exit_commands.include?(input)
            puts "\nThanks for visiting the Music Library. Your session is completed!!\n"
          else
            puts "\nSorry, I didn't recognize your command!\n"
          end
      end
    end
  end

  def list_songs
    puts "\n"
    Song.all.sort{|a,b| a.name <=> b.name}.each.with_index(1) do |s, i|
      puts "#{i}. #{s.name} -- by #{s.artist.name}"
    end
  end

  def list_artists
    puts "\n"
    Artist.all.sort{|a,b| a.name <=> b.name}.each.with_index(1) { |a,i| puts "#{i}. #{a.name}" }
  end

  def list_genres
    puts "\n"
    Genre.all.sort{|a,b| a.name <=> b.name}.each.with_index(1) { |g,i| puts "#{i}. #{g.name}" }
  end

  def show_artist
    puts "What artist by name you like to list songs for?"
    artist_input = gets.strip
    if artist = Artist.find_by_name(artist_input) # note that nil treated as false
      puts "\n"
      artist.songs.each.with_index(1) { |s,i| puts "#{i}. #{s.name}" }
    else
      puts "\nSorry, that artist was not found!"
    end
  end

  def show_genre
    puts "What genre by name you like to list songs for?"
    genre_input = gets.strip
    if genre = Genre.find_by_name(genre_input) # note that nil treated as false
      puts "\n"
      genre.songs.each.with_index(1) { |s,i| puts "#{i}. #{s.name} -- by #{s.artist.name}" }
    else
      puts "\nSorry, that genre was not found!"
    end
  end

  def play_song
    puts "What song number would you like to play?"
    song_input = gets.strip
    song = Song.all.sort{|a,b| a.name <=> b.name}[song_input.to_i-1]
    if song == nil
      puts "\nSorry, no song with that number was found!!"
    else
      puts "\nPlaying #{song.name} -- by #{song.artist.name}"
    end
  end
end
