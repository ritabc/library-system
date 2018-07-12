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

post('/patron_add') do
  name = params['name']
  new_patron = Patron.new(:name => name, :id => nil)
  new_patron.save
  @name = new_patron.name
  @id = new_patron.id
  erb(:patron_success)
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

post('/checkout-success') do
  patron_id = params.fetch("patron_id").to_i
  book_id = params.fetch("book_id").to_i
  @new_checkout = Checkout.new({:book_id => book_id, :patron_id => patron_id, :checkout_date => Date.today, :id => nil})
  @new_checkout.save
  book = Book.find(book_id)
  book.update({:title => book.title, :author => book.author, :in_stock => false})
  @book = book
  erb(:checkout_success)
end
