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

patch("/book_update") do
  title = params.fetch('title')
  author = params.fetch('author')
  @book = Book.find(params.fetch('id').to_i())
  @book.update({:title => title, :author =>author})
  erb(:success)
end

get('/librarian') do
  erb(:librarian)
end

get('/lib-books-list') do
  @books = Book.all
  erb(:lib_books_list)
end

get('/patron') do
  @books = Book.all
  erb(:patron)
end

get('/lib_book/:id') do
  @book = Book.find(params.fetch("id").to_i())
  erb(:librarian_book)
end

get('/patron_book/:id') do
  @book = Book.find(params.fetch("id").to_i())
  erb(:patron_book)
end

get('/back') do
  # @books = Book.all()
  erb(:index)
end
