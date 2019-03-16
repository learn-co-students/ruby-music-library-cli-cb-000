class Genre
    extend Concerns::Findable
    @@all = []
    attr_accessor :name, :songs

    def initialize(name)

      @name = name
      @songs = []
      #puts("Genre::Initialize name=#{@name}")
    end

    def self.create(name)
      genre = Genre.new(name)
      genre.save
      genre
    end
    def artists
        artistsObjArr = []
       
       @songs.each do |s|
          artistsObjArr << s.artist
       end

         artistsObjArr.uniq
    end



    def save
      @@all << self
    end

    def self.destroy_all
      @@all.clear
    end

    def self.all
      @@all
    end

    def self.printAll
      @@all.each{ |g| puts("Genre:  #{g.name}\n")}
    end
  end
