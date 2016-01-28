class AddIndexToIngredientsAndInstructions < ActiveRecord::Migration
  def change
    add_column(:ingredients, :recipe_id, :integer)
    add_column(:instructions, :recipe_id, :integer)
  end
end
