require 'pry'

class MusicLibraryController


  def initialize(path="./db/mp3s")
    importer=MusicImporter.new(path)
    importer.import
  end #init

  def call
    puts "Welcome to your music library!"
    puts "To list all of your songs, enter 'list songs'."
    puts "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the genres in your library, enter 'list genres'."
    puts "To list all of the songs by a particular artist, enter 'list artist'."
    puts "To list all of the songs of a particular genre, enter 'list genre'."
    puts "To play a song, enter 'play song'."
    puts "To quit, type 'exit'."
    puts "What would you like to do?"

    input = ""
    while input!="exit" do
      input = gets.chomp

      case input
      when "list songs"
       self.list_songs
      when "list artists"
        self.list_artists
      when "list genres"
        self.list_genres
      when "list artist"
        self.list_songs_by_artist
      when "list genre"
        self.list_songs_by_genre
      when "play song"
        self.play_song
      end


    end
  end #call

  # **************************************************************************my own DRY
  def list  # [s.artist.name,s.name,s.genre.name]
    songsall = []
    Song.all.each {|s| songsall << [s.artist.name,s.name,s.genre.name]}
    songsall
  end
  # **************************************************************************
  def list_songs
      songsall=self.list
      songsall.sort_by! {|s| s[1]}
      count = 1
      songsall.each do |s|
        puts "#{count}. #{s[0]} - #{s[1]} - #{s[2]}"
        count += 1
      end
  end

  def list_artists  #reachout to Artist.all
    artistall=Artist.all
    list=artistall.collect{|artist| artist.name}.sort
    count=1
    list.each do |artist|
      puts "#{count}. #{artist}"
      count +=1
    end
  end

  def list_genres
    genresall=Genre.all
    list=genresall.collect{|genre| genre.name}.sort
    count=1
    list.each do |genre|
      puts "#{count}. #{genre}"
      count +=1
    end
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    artistname = gets.chomp
    artistobj = Artist.find_by_name(artistname)
    list = []
    if !artistobj.nil?
      artistobj.songs.each {|s| list << [s.name,s.genre.name]}
      list.sort_by! {|s| s[0]}
      counter = 1
      list.each do |s|
        puts "#{counter}. #{s[0]} - #{s[1]}"
        counter += 1
      end
    end #if
  end


  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    genrename = gets.strip
    genreobj = Genre.find_by_name(genrename)
    list = []
    if !genreobj.nil?
      genreobj.songs.each {|s| list << [s.artist.name,s.name]}
      list.sort_by! {|s| s[1]}
      counter = 1
      list.each do |s|
        puts "#{counter}. #{s[0]} - #{s[1]}"
        counter += 1
      end
    end #if
  end #list_songs_by_genre


  def play_song #list comes from #list_songs
    puts "Which song number would you like to play?"
    songnumber=gets.strip
    songsall=self.list
    songsall.sort_by! {|s| s[1]}
    songnumber=songnumber.to_i
    if songnumber < songsall.length && songnumber >=1
      songnumber=songnumber-1
      puts "Playing #{songsall[songnumber][1]} by #{songsall[songnumber][0]}"
    end #if
   end # play_song
end #class
