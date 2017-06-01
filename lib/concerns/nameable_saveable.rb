module Concerns
  class NameableSaveable

    ### CLASS METHODS & VARIABLES ###
      # IMPORTANT NOTE -->> advice for the following setup is found here:
      # https://stackoverflow.com/questions/1251352/ruby-inherit-code-that-works-with-class-variables
      # Crucial quote from this stackoverflow entry:
      # "The @@variables aren't class variables. They are class hierarchy variables,
      # i.e. they are shared between the entire class hierarchy, including all
      # subclasses and all instances of all subclasses.
      # Ruby doesn't have class variables in the sense that, say, Java (where they
      # are called static fields) has them. It doesn't need class variables, because
      # classes are also objects, and so they can have instance variables just like
      # any other object. All you have to do is to remove the extraneous @s. (And you
      # will have to provide an accessor method for the class instance variable.)"

    class << self  # establishes a block for defining class methods and fields
      
      attr_reader :all  # can be used here thanks to block established by "class << self"
      @all = Array.new

      def destroy_all()
        @all = Array.new
      end

      def create(name)
        return self.new(name)
      end
    end

    ### INSTANCE METHODS & VARIABLES ###
    attr_accessor :name

    def initialize(name)
      self.name = name
      self.save
    end

    def save()
      self.class.all.push(self) unless self.class.all.detect{|n| n.name == name}
      return self # permits method chaining
    end
  end
end
