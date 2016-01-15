require('sinatra')
require('sinatra/reloader')
require('./lib/word')
also_reload('lib/**/*.rb')
require('pry')

get('/') do
  @words = Word.all.sort_by {|obj| obj.word}
  erb(:index)
end

post('/add_word') do
  Word.new(:word => params.fetch("word")).save unless params.fetch("word").empty?
  redirect('/')
end

get('/word_definitions/:id') do
  @word = Word.find(params.fetch("id").to_i)
  binding.pry
  erb(:word_definitions)
end
