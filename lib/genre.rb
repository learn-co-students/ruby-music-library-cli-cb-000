class Genre
  extend Concerns::ClassMethods
  include Concerns::InstanceMethods

  attr_accessor :name, :songs

  @@all = []

  def self.all
    @@all
  end

  def initialize (name)
    super
    @songs = []
  end

end
