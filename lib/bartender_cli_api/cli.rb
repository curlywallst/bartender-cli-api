class CLI

    def start
        input = ""
        puts "Welcome to the Bartender Helper"
        menu
    end

    def menu
        puts ""
        prompt
        puts ""
        input = gets.strip.downcase
        while input != "exit" do
            if input == "glass"
                Api.get_glasses if Glass.all == []
                print_selection(Glass.all)
                select_from_group("glass", Glass.all)
            elsif input == "ingredient"
                Api.get_ingredients if Ingredient.all == []
                print_selection(Ingredient.all)
                select_from_group("ingredient", Ingredient.all)
            else
                print_error
            end
            prompt
            input = gets.strip.downcase
        end
        goodbye
    end

    def select_from_group(group_type, group)
        drinks_prompt
        input = gets.strip.downcase
        while input != "exit" do
            if input.to_i > 0 && input.to_i <= group.length
                Api.get_drinks_by_group(group_type, group[input.to_i-1]) if group[input.to_i-1].drinks.length == 0
                print_selection(group[input.to_i-1].drinks)
                select_from_drinks_group(group[input.to_i-1])
            elsif input == 'list'
                print_selection(group)
            elsif input == 'menu'
                menu
            else
                print_error
                select_from_group(group_type, group)
            end
            drinks_prompt
            input = gets.strip.downcase
        end
        goodbye
    end

    def select_from_drinks_group(group)
        drink_prompt
        input = gets.strip.downcase
        while input != "exit" do
            if input.to_i > 0 && input.to_i <= group.drinks.length
                Api.get_drink_details(group.drinks[input.to_i-1]) if group.drinks[input.to_i-1].ingredients.length == 0
                print_drink(group.drinks[input.to_i-1])
            elsif input == 'list'
                print_selection(group.drinks)
            elsif input == 'menu'
                menu
            else
                print_error
                select_from_drinks_group(group)
            end
            drink_prompt
            input = gets.strip.downcase
        end
        goodbye

    end

    def prompt
        puts "Enter 'ingredient' to see a list of ingredients , 'glass' to see a list of glasses or 'exit' to exit." 
    end

    def drinks_prompt
        puts ""
        puts "Type a number to see the list of associate drinks, 'list' to see the list again, 'menu' to go back to the main menu or 'exit' to exit."
    end

    def drink_prompt
        puts ""
        puts "Type a number to see the recipe, 'menu' to go back to the main menu or 'exit' to exit."
    end 

    def print_error
        puts ""
        puts "Not sure what you meant there"
    end

    def print_selection(selection)
        puts ""
        selection.each.with_index(1) do |item, index|
            puts "#{index}. #{item.name}"
        end
    end

    def print_drink(drink)
        puts "----------"
        puts ""
        puts "#{drink.name} Recipe:"
        puts ""
        puts "-----------"
        puts ""
        puts "Glass Type: #{drink.glass}"
        puts ""
        puts "Instructions: #{drink.instructions}"
        puts ""
        puts "Ingredients:"
        puts ""
        drink.ingredients.each_with_index do |ingredient, index|
          puts "#{ingredient} - #{drink.measures[index]}"
        end
        puts ""
    end

    def goodbye
        puts "Enjoy!"
        exit
    end
end