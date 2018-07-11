require('sinatra')
require("sinatra/reloader")
also_reload('lib/**/*.rb')
require('./lib/Author')
require('./lib/Book')
require('./lib/Checkout')
require('./lib/Patron')
require('pg')
require('pry')

DB = PG.connect({:dbname => 'library'})

get('/') do
  @books = Book.all
  erb(:index)
end

post('/book_add') do
  title=params['title']
  author=params['author']
  book = Book.new(:author => author, :title => title, :id => nil)
  book.save
  erb(:success)
end

get('/librarian') do
  erb(:librarian)
end

get('/patron') do
  erb(:patron)
end

get('/back') do
  @books = Book.all()
  erb(:index)
end
