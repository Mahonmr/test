class Recipe < ActiveRecord::Base
  has_many :instructions
  has_many :ingredients
  has_and_belongs_to_many :tags

  def self.results(search)
    results = []
    search_tag = Tag.find_by_tag(search)
    results = search_tag.recipes unless search_tag.nil?
    search_ingredents = Ingredient.where(ingredient: search)
    search_ingredents.each do |ingredient|
      results << ingredient.recipe
    end
    @results = results.compact
  end
end
