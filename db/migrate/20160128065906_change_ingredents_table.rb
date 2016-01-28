class ChangeIngredentsTable < ActiveRecord::Migration
  def change
    rename_column(:ingredients, :type, :ingredient)
  end
end
