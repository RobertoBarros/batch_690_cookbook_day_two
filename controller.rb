require_relative 'view'
require_relative 'scrape_allrecipes_service'

class Controller
  def initialize(cookbook)
    @cookbook = cookbook
    @view = View.new
  end

  def list
    # 1. Recuperar todas as receitas do cookbook
    recipes = @cookbook.all
    # 2. Mandar as receitas para a view exibir
    @view.display(recipes)
  end

  def create
    # 1. Pegar o nome da receita
    name = @view.ask_name
    # 2. Pegar a descrição da receita
    description = @view.ask_description

    # Pegar o rating da receita
    rating = @view.ask_rating

    # Pegar o tempo de preparo
    prep_time = @view.ask_preptime

    # 3. Instanciar uma nova receita
    new_recipe = Recipe.new(name, description, rating, prep_time)

    # 4. Adicionar a receita ao cookbook
    @cookbook.add_recipe(new_recipe)
  end

  def mark_as_done
    # Listar todas as receitas
    list

    # Pegar o index da receita para marcar como done
    index = @view.ask_index

    # Marcar como done e salvar
    @cookbook.mark_as_done(index)
  end

  def destroy
    # 1. Mostrar todas as receitas
    list
    # 2. Pegar qual o índice da receita a ser excluída
    index = @view.ask_index

    # 3. Passar para o cookbook excluir a receita
    @cookbook.remove_recipe(index)
  end

  def import_from_web
    ingredient = @view.ask_ingredient
    scrape = ScrapeAllrecipesService.new(ingredient)
    new_recipe = scrape.call
    @cookbook.add_recipe(new_recipe)
  end
end
