class Ingredient
    attr_accessor :name, :drinks
  
    @@all = []
  
    def initialize(name: nil)
      @name = name
      @@all << self
      @drinks = []
    end
  
    def self.all
      @@all
    end
  end