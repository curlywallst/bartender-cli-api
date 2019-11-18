class Api
 
    def self.get_drinks(alcohol)
        url = "https://www.thecocktaildb.com/api/json/v1/1/filter.php?i=#{alcohol}"
        uri = URI(url)
        response = Net::HTTP.get(uri)

        drinks = JSON.parse(response)["drinks"].each do |c|
            Drink.new(name: c["strDrink"], drink_id: c["idDrink"], alcohol: alcohol) if c["strDrink"] != nil    
        end
    end

    def self.get_drink_details(drink)
        url = "https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=#{drink.drink_id}"
        uri = URI(url)
        response = Net::HTTP.get(uri)
        drink_details = JSON.parse(response)
        drink.alcoholic = drink_details["drinks"][0]["strAlcoholic"]
        drink.glass = drink_details["drinks"][0]["strGlass"]
        drink.instructions = drink_details["drinks"][0]["strInstructions"]
        drink_details["drinks"][0].keys.each do |i|
          drink.ingredients << drink_details["drinks"][0][i] if (i.include? "Ingredient") && drink_details["drinks"][0][i] != "" && drink_details["drinks"][0][i] != " " && drink_details["drinks"][0][i] != nil
          drink.measures << drink_details["drinks"][0][i].gsub("\n", "") if (i.include? "Measure") && drink_details["drinks"][0][i] != "" && drink_details["drinks"][0][i] != " " && drink_details["drinks"][0][i] != nil
        end
    end
end