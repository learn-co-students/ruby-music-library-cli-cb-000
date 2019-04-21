class MusicLibraryController

  def initialize(optional_path = "./db/mp3s")
    @optional_path = optional_path
    @new_music_importer = MusicImporter.new(optional_path)
    @new_music_importer.import
  end

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
    # user_input = gets.chomp
    # counter = 1
    # if user_input != "exit"
    #   until counter > 3
    #     new_user_input = gets.chomp
    #     counter += 1
    #   end
    # end
  end

  def list_songs
    names_array = []
    imports = @new_music_importer.import
    imports.each do |imported_song|
      names_array << imported_song.name
    end
    alpha_array = names_array.sort
    counter = 1
    if alpha_array != []
      alpha_array.each do |song_name|
        song_variable = Song.find_by_name(song_name)
        puts "#{counter}. #{song_variable.filename.split(".")[0]}"
        counter +=1
      end
    end
  end

  # def list_artists
  #   artists_array = []
  #   imports = @new_music_importer.import
  #   imports.each do |imported_song|
  #     artists_array << imported_song.filename.split(" - ")[0]
  #     artists_array = artists_array.sort
  #   end
  #   unique_artists_array = []
  #   artists_array.each do |tested_artist_name|
  #     if unique_artists_array == []
  #       unique_artists_array << tested_artist_name
  #     else
  #     unique = true
  #     unique_artists_array.each do |existing_artist_name|
  #       if existing_artist_name == tested_artist_name
  #         unique = false
  #       end
  #     end
  #     if unique == true
  #       unique_artists_array << tested_artist_name
  #     end
  #     end
  #   end
  #   counter = 1
  #   unique_artists_array.each do |artist_name|
  #     puts "#{counter}. #{artist_name}"
  #     counter += 1
  #   end
  # end

  def list_artists
    imports = @new_music_importer.import
    artists_array = []
    imports.each do |imported_song|
      if artists_array == []
        artists_array << imported_song.artist.name
      else
        unique = true
        artists_array.each do |existing_artist_name|
          if existing_artist_name == imported_song.artist.name
            unique = false
          end
        end
        if unique == true
          artists_array << imported_song.artist.name
        end
      end
    end
    Artist.all.each do |artist_object|
      unique = true
      artists_array.each do |existing_artist_name|
        if artist_object.name == existing_artist_name
          unique = false
        end
      end
      if unique == true
        artists_array << artist_object.name
      end
    end
    counter = 1
    artists_array.sort.each do |artist_name|
      puts "#{counter}. #{artist_name}"
      counter += 1
    end
  end

  def list_songs
    names_array = []
    imports = @new_music_importer.import
    imports.each do |imported_song|
      names_array << imported_song.name
    end
    alpha_array = names_array.sort
    counter = 1
    if alpha_array != []
      alpha_array.each do |song_name|
        song_variable = Song.find_by_name(song_name)
        puts "#{counter}. #{song_variable.filename.split(".")[0]}"
        counter +=1
      end
    end
  end

  # def list_artists
  #   artists_array = []
  #   imports = @new_music_importer.import
  #   imports.each do |imported_song|
  #     artists_array << imported_song.filename.split(" - ")[0]
  #     artists_array = artists_array.sort
  #   end
  #   unique_artists_array = []
  #   artists_array.each do |tested_artist_name|
  #     if unique_artists_array == []
  #       unique_artists_array << tested_artist_name
  #     else
  #     unique = true
  #     unique_artists_array.each do |existing_artist_name|
  #       if existing_artist_name == tested_artist_name
  #         unique = false
  #       end
  #     end
  #     if unique == true
  #       unique_artists_array << tested_artist_name
  #     end
  #     end
  #   end
  #   counter = 1
  #   unique_artists_array.each do |artist_name|
  #     puts "#{counter}. #{artist_name}"
  #     counter += 1
  #   end
  # end

  def list_genres
    imports = @new_music_importer.import
    genres_array = []
    imports.each do |imported_song|
      if genres_array == []
        genres_array << imported_song.genre.name
      else
        unique = true
        genres_array.each do |existing_genre_name|
          if existing_genre_name == imported_song.genre.name
            unique = false
          end
        end
        if unique == true
          genres_array << imported_song.genre.name
        end
      end
    end
    Genre.all.each do |genre_object|
      unique = true
      genres_array.each do |existing_genre_name|
        if genre_object.name == existing_genre_name
          unique = false
        end
      end
      if unique == true
        genres_array << genre_object.name
      end
    end
    counter = 1
    genres_array.sort.each do |genre_name|
      puts "#{counter}. #{genre_name}"
      counter += 1
    end
  end

  # def list_songs_by_artist
  #   puts "Please enter the name of an artist:"
  #   artist_name = gets.chomp
  #   artist_object = Artist.find_by_name(artist_name)
  #   counter = 1
  #   if artist_object == nil
  #     self.list_songs_by_artist
  #   else
  #     artist_object.songs.each do |song|
  #       puts "#{counter}. #{song.name} - #{song.genre.name}"
  #       counter += 1
  #     end
  #   end
  # end

end
