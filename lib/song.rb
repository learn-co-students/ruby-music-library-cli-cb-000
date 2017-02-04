class Song

  attr_accessor :name
  @@all = []

  def initialize(name,artist=nil,genre=nil)
    @name = name
    self.artist = artist
    self.genre = genre
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def save
    @@all << self
  end

  def self.create(name)
    new_song = Song.new(name)
    new_song.save
    new_song
  end

  def artist
    @artist
  end

  def artist=(artist)
    if artist
      @artist = artist
      artist.add_song(self)
    end
  end

  def genre
    @genre
  end

  def genre=(genre)
    if genre
      @genre = genre
      genre.add_song(self)
    end
  end

  def self.find_by_name(name)
    @@all.detect{|s|s.name == name}
  end

  def self.find_or_create_by_name(name)
    song = @@all.detect{|s|s.name == name}
    song = Song.create(name) if !song
    song
  end

  def self.new_from_filename(filename)
    artist_name, song_name, genre_name = filename.chomp('.mp3').split(' - ')
    artist = Artist.find_or_create_by_name(artist_name)
    genre = Genre.find_or_create_by_name(genre_name)
    song = Song.new(song_name,artist,genre)
    song
  end

  def self.create_from_filename(filename)
    artist_name, song_name, genre_name = filename.chomp('.mp3').split(' - ')
    song = find_or_create_by_name(song_name)
    song.artist = Artist.find_or_create_by_name(artist_name)
    song.genre = Genre.find_or_create_by_name(genre_name)
    song
  end

  def self.play_song(song_number)
    song = self.all[song_number]
    puts "Playing #{song.artist.name} - #{song.name} - #{song.genre.name}"
  end

  def self.print_all
    c = 1
    self.all.each do |song|
      puts "#{c}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
      c += 1
    end
  end



end