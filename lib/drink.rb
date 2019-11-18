class Drink
    attr_accessor :name, :drink_id, :category, :alcoholic, :glass, :instructions, :ingredients, :ingredient, :measures, :alcohol
    @@all = []

    def initialize(name: nil, ingredient: nil, drink_id: nil)
        @name = name
        @ingredient = ingredient
        @drink_id = drink_id
        @ingredients = []
        @measures = []
        @@all << self
    end

    def self.all
        @@all
    end

    def self.find_by_ingredient(ingredient)
        self.all.select{|d| d.ingredient == ingredient}
    end

end