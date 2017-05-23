class Song
  extend Concerns::ClassMethods
  include Concerns::InstanceMethods

  attr_accessor :name, :artist, :genre

  @@all = []

  def self.all
    @@all
  end

  def initialize(name)
    super
  end

end
