class MusicLibraryController
  attr_accessor :path

  def initialize (path = "./db/mp3s")
    @path = path
    MusicImporter.new(path).import
    self.call


  end

  def call
    puts "input please?"
    input = gets
    if input.to_s.strip != "exit" && input !=nil
      puts "input = #{input.to_s.strip}"
      self.input_handler(input.to_s.strip)
      self.call
    end
  end

  def input_handler (input)
    case input
      when "list songs"
        Song.all.each_with_index do |s, index|
          puts "#{(index+1).to_s}. #{s.artist.name} - #{s.name} - #{s.genre.name}"
        end
      when "list artists"
          Artist.all.each do |a|
            puts a.name
          end
      when "play song"
          puts "number?"
          i = gets.chomp.to_i-1
          s = Song.all[i]
          puts "Playing #{s.artist.name} - #{s.name} - #{s.genre.name}"
      when "list genres"
          Genre.all.each do |g|
            puts g.name
          end
      when "list artist"
          puts "artist name?"
          artist = gets.chomp
          Artist.find_by_name(artist).songs.each do |s|
            puts "#{s.artist.name} - #{s.name} - #{s.genre.name}"
          end
      when "list genre"
          puts "genre name?"
          genre = gets.chomp
          Genre.find_by_name(genre).songs.each do |s|
            puts "#{s.artist.name} - #{s.name} - #{s.genre.name}"
          end
      else
        puts "command not found"
      end
    end



end
