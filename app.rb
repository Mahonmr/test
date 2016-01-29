require('sinatra')
require('sinatra/reloader')
require('sinatra/activerecord')
require('./lib/helper')
require('./lib/recipes')
require('./lib/instructions')
require('./lib/ingredients')
require('./lib/tags')
require('mysql2')
require('pry')
also_reload('./lib/**/*.rb')

get('/') do
  erb(:index)
end

#====================recipes====================================================

get('/recipes') do
  @tags = Tag.all
  @recipes = Recipe.all
  erb(:"/recipes/recipes")
end

get('/recipes/new') do
  erb(:"/recipes/recipes_form")
end

post('/recipes') do
  Recipe.create(params)
  redirect('/recipes')
end

get('/recipes/:id') do
  @recipe = Recipe.find(params[:id].to_i)
  erb(:"/recipes/recipes_view")
end

get('/recipes/:id/edit') do
  @recipe = Recipe.find(params[:id].to_i)
  erb(:"/recipes/recipes_edit")
end

patch('/recipes/:id') do
  @recipe = Recipe.find(params[:id].to_i)
  @recipe.update(ranking: params[:ranking].to_s, name: params[:name])
  redirect('/recipes')
end

delete('/recipes/:id') do
  @recipe = Recipe.find(params[:id].to_i)
  @recipe.delete
  redirect('/recipes')
end

#====================instructions===============================================

get('/recipes/:id/instructions') do
  @recipe = Recipe.find(params[:id].to_i)
  erb(:"/instructions/instructions")
end

get('/recipes/:id/instructions/new') do
  @recipe = Recipe.find(params[:id].to_i)
  erb(:"/instructions/instructions_form")
end

post('/recipes/:recipes_id/instructions') do
  @recipe = Recipe.find(params[:recipes_id].to_i)
  @recipe.instructions.create(step: params[:step].to_i, task: params[:task])
  redirect("/recipes/#{@recipe.id}/instructions")
end

get('/recipes/:recipe_id/instructions/:id/edit') do
  @instruction = Instruction.find(params[:id].to_i)
  erb(:"/instructions/instructions_edit")
end

patch('/recipes/:recipe_id/instructions/:id') do
  @instruction = Instruction.find(params[:id].to_i)
  @instruction.update(step: params[:step].to_i, task: params[:task], recipe_id: params[:recipe_id].to_s)
  redirect("/recipes/#{@instruction.recipe_id}/instructions")
end

delete('/recipes/:recipe_id/instructions/:id') do
  @instruction = Instruction.find(params[:id].to_i)
  @instruction.destroy
  redirect("/recipes/#{@instruction.recipe_id}/instructions")
end


#====================ingredients================================================


get('/recipes/:id/ingredients') do
  @recipe = Recipe.find(params[:id].to_i)
  erb(:"/ingredients/ingredients")
end

get('/recipes/:id/ingredients/new') do
  @recipe = Recipe.find(params[:id].to_i)
  erb(:"/ingredients/ingredients_form")
end

post('/recipes/:recipes_id/ingredients') do
  @recipe = Recipe.find(params[:recipes_id].to_i)
  @recipe.ingredients.create(amount: params[:amount].to_i, ingredient: params[:ingredient])
  redirect("/recipes/#{@recipe.id}/ingredients")
end

get('/recipes/:recipe_id/ingredients/:id/edit') do
  @ingredient = Ingredient.find(params[:id].to_i)
  erb(:"/ingredients/ingredients_edit")
end

patch('/recipes/:recipe_id/ingredients/:id') do
  @ingredient = Ingredient.find(params[:id].to_i)
  @ingredient.update(amount: params[:amount].to_i, ingredient: params[:ingredient], recipe_id: params[:recipe_id].to_s)
  redirect("/recipes/#{@ingredient.recipe_id}/ingredients")
end

delete('/recipes/:recipe_id/ingredients/:id') do
  @ingredient = Ingredient.find(params[:id].to_i)
  @ingredient.destroy
  redirect("/recipes/#{@ingredient.recipe_id}/ingredients")
end

#=======================tags====================================================

get('/tags') do
  @tags = Tag.all
  erb(:"/tags/tags")
end

get('/tags/new') do
  erb(:"/tags/tags_form")
end

post('/tags') do
  Tag.create(params)
  redirect("/tags")
end

get('/tags/:id/edit') do
  @tag = Tag.find(params[:id].to_i)
  erb(:"/tags/tags_edit")
end

patch('/tags/:id') do
  @tag = Tag.find(params[:id].to_i)
  @tag.update(tag: params[:tag])
  redirect('/tags')
end

delete('/tags/:id') do
  @tag = Tag.find(params[:id].to_i)
  @tag.delete
  redirect('/tags')
end

#======================tags recipes=============================================

post('/recipes/:recipe_id/tags') do
  recipe = Recipe.find(params[:recipe_id].to_i)
  tag = Tag.find(params[:tag_id].to_i)
  recipe.tags << tag
  redirect('/recipes')
end

delete('/recipes/:recipe_id/tags/:tag_id') do
  recipe = Recipe.find(params[:recipe_id].to_i)
  tag = Tag.find(params[:tag_id].to_i)
  recipe.tags.delete(tag)
  redirect ("/recipes/#{params[:recipe_id].to_i}")
end

#==================search results===============================================

get('/search_results') do
  @results = Recipe.results(params[:search])
  erb(:"/search_results")
end
