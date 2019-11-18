class CLI

    def menu
        input = ""
        puts "Welcome to the Bartender Helper"
        puts ""
        puts "Enter a type of alcohol to select to see drink recipes or 'exit' to exit."
        puts ""
        @alcohol = gets.strip.downcase
        Api.get_drinks(@alcohol)
        drinks = Drink.all
        print_drinks(drinks)
        prompt
        input = gets.strip.downcase
        while input != "exit" do
            if input == "list"
                print_drinks(Drink.find_by_alcohol(@alcohol))
            elsif input.to_i > 0 && input.to_i <= Drink.find_by_alcohol(@alcohol).length
                drink = Drink.find_by_alcohol(@alcohol)[input.to_i - 1]
                Api.get_drink_details(drink) if drink.ingredients.length == 0
                print_drink(drink)
            elsif input == "alcohol"
                puts ""
                puts "What type of alcohol would you like to see drinks with?"
                puts ""
                @alcohol = gets.strip.downcase
                Api.get_drinks(@alcohol)
                print_drinks(Drink.find_by_alcohol(@alcohol))
            else
                puts "I do not understand"
            end
            prompt
            input = gets.strip.downcase
        end
    end

    def prompt
        puts ""
        puts "Type a number to see the recipe, 'list' to see the last list again or 'alcohol' to pick another alcohol type and see a new list or 'exit' to exit."
    end

    def print_drinks(drinks)
        drinks.each.with_index(1) do |drink, index|
            puts "#{index}. #{drink.name}"
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
end