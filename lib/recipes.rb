class Recipe < ActiveRecord::Base
  has_many :instructions
  has_many :ingredients
  has_and_belongs_to_many :tags

  scope :search_by_ingredient, lambda { |search| joins(:ingredients).where("ingredients.ingredient" => search)}

  def self.results(search)
    search_tag = Tag.find_by_tag(search)
    results_by_tag = search_tag.recipes unless search_tag.nil?
    results_by_ingredient = search_by_ingredient(search)
    return results = results_by_tag.nil? ? (results_by_ingredient) : (results_by_tag << results_by_ingredient)
  end
end
