class Api
 
    def self.get_drinks(ingredient)
        url = "https://www.thecocktaildb.com/api/json/v1/1/filter.php?i=#{ingredient}"
        uri = URI(url)
        response = Net::HTTP.get(uri)

        drinks = JSON.parse(response)["drinks"].each do |c|
            Drink.new(name: c["strDrink"], drink_id: c["idDrink"], ingredient: ingredient) if c["strDrink"] != nil    
        end
    end

    def self.get_glasses
      url = "https://www.thecocktaildb.com/api/json/v1/1/list.php?g=list"
      uri = URI(url)
      response = Net::HTTP.get(uri)
      glases = JSON.parse(response)["drinks"].each do |c|
        Glass.new(name: c["strGlass"]) if c["strGlass"] != ""
      end
    end

    def self.get_ingredients
      url = "https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list"
      uri = URI(url)
      response = Net::HTTP.get(uri)
      ingredients = JSON.parse(response)["drinks"].each do |c|
        Ingredient.new(name: c["strIngredient1"]) if c["strIngredient1"] != nil
      end  
    end

    def self.get_drinks_by_group(group_type, group)
        url = "https://www.thecocktaildb.com/api/json/v1/1/filter.php?#{group_type[0]}=#{group.name.gsub(" ","_")}"
        uri = URI(url)
        response = Net::HTTP.get(uri)
        drinks = JSON.parse(response)["drinks"]
        drinks.each do |d|
          drink = Drink.new(name: d["strDrink"], drink_id: d["idDrink"])
          group.drinks << drink
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