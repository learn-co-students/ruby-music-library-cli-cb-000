require 'pry'

module Memorable
  module ClassMethods
    @all = []

    def all
      return @all
    end

    def all=(array)
      @all = array
    end

    def create(name)
      new_instance = self.new(name)
      return new_instance
    end

    def count
      self.all.count
    end

    def reset_all
      self.all.clear
    end

    def destroy_all
      self.all = []
    end

  end

  module InstanceMethods
    attr_accessor :name

    def initialize(name, artist=nil, genre=nil)
      self.class.all << self
      self.name = name
    end

    def save
      self.class.all << self
    end

  end

end
