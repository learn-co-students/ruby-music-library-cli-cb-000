require 'pry'

class MusicLibraryController

  def initialize(path='./db/mp3s')
    @path = path
    musicImporter =  MusicImporter.new(path)
    musicImporter.import
  end

  def call
    userinput = gets "what do you want?"

    case userinput

    when "list songs"
        self.listSongs
        self.call
    when "list artists"
        self.listArtists
        self.call
    when "list genres"
        self.listGenres
        self.call
    when "play song"
        self.playSong
        self.call
    when "list artist"
        artist = gets"what artist?"
        listArtist(artist)
        self.call
    when "list genre"
        genre = gets "what genre?"
        listGenre(genre)
        self.call
    when "exit"
      return
    else
      self.call
    # if userinput != 'exit'
      # self.call
    # end
  end
  end

  def listArtist(artist)
    # puts "listing songs for artist"
    # binding.pry
    Song.all.each do |s|
      if s.artist.name == artist
        puts "#{s.artist.name} - #{s.name} - #{s.genre.name}"


      end
    end
  end

  def listGenre(genre)
    Song.all.each do |s|
      if s.genre.name == genre
        puts "#{s.artist.name} - #{s.name} - #{s.genre.name}"
      end
    end
  end


  def listSongs
    Song.all.each do |s|
      i = Song.all.index(s) + 1
      puts "#{i}. #{s.artist.name} - #{s.name} - #{s.genre.name}"
    end


  end

  def listArtists
    Song.all.each do |s|
      puts s.artist.name
    end
  end

  def listGenres
    Song.all.each do |s|
      puts s.genre.name
    end

  end

  def playSong
    input2 = gets "What song would you like to play?"
    i = input2.to_i - 1
    s = Song.all[i]
    puts "Playing #{s.artist.name} - #{s.name} - #{s.genre.name}"

  end


end
