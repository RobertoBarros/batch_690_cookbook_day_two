require 'colored'

class View
  def ask_name
    puts 'Enter recipe name:'.green
    gets.chomp
  end

  def ask_description
    puts 'Enter recipe description'.green
    gets.chomp
  end

  def ask_rating
    puts 'Enter recipe rating (1-5)'
    gets.chomp.to_i
  end

  def ask_index
    puts 'Enter index of recipe:'
    gets.chomp.to_i - 1
  end

  def ask_preptime
    puts 'Enter recipe prep. time:'
    gets.chomp
  end

  def ask_ingredient
    puts 'What ingredient would you like a recipe for?'
    gets.chomp
  end

  def display(recipes)
    puts '-' * 80
    puts ' RECIPES LIST'.red_on_blue
    puts '-' * 80

    recipes.each_with_index do |recipe, index|
      index = (index + 1).to_s.bold.white
      name = recipe.name.green
      description = recipe.description.cyan
      rating = "(#{recipe.rating}/5)".green
      done = recipe.done? ? '[X]'.green : '[ ]'.blue

      puts "  #{index} - #{done} #{name}: #{description} #{rating} - Prep. Time: #{recipe.prep_time}"
    end

    puts '-' * 80
  end
end