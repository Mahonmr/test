class Word
  attr_reader(:word, :id)

  @@words = []

  def initialize(attributes)
    @word = attributes.fetch(:word)
    @definitions = []
    @id = @@words.length + 1
  end

  def save
    @@words << self
  end

  define_singleton_method(:find) do |id|
    @@words.each do |word|
      return word if word.id == id
    end
  end

  define_singleton_method(:all) do
    @@words
  end
end
