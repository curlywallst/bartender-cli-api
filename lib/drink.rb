class Drink
    attr_accessor :name, :drink_id, :category, :alcoholic, :glass, :instructions, :ingredients, :ingredient, :measures, :alcohol
    @@all = []

    def initialize(name: nil, alcohol: nil, drink_id: nil)
        @name = name
        @alcohol = alcohol
        @drink_id = drink_id
        @ingredients = []
        @measures = []
        @@all << self
    end

    def self.all
        @@all
    end

    def self.find_by_alcohol(alcohol)
        self.all.select{|d| d.alcohol == alcohol}
    end

end