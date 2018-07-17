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

get('/librarian') do
  @books = Book.all
  erb(:librarian_books_list)
end

get('/add-book') do
  erb(:librarian_add_book)
end

post('/book_add') do
  title=params['title']
  author=params['author']
  book = Book.new(:author => author, :title => title, :id => nil)
  book.save
  erb(:book_add_success)
end

get('/librarian/info-book-:id') do
  @book = Book.find(params.fetch("id").to_i())
  erb(:librarian_book)
end

patch("/book_update") do
  title = params.fetch('title')
  author = params.fetch('author')
  @book = Book.find(params.fetch('id').to_i())
  @book.update({:title => title, :author => author})
  erb(:book_update_success)
end

delete('/book-delete-success') do
  book = Book.find(params.fetch('book_id').to_i)
  @book_title = book.title
  book.delete
  erb(:book_delete_success)
end

get('/search') do
  erb(:librarian_search)
end

post('/librarian-search-result') do
  @title = params.fetch('title')
  @author = params.fetch('author')
  @book = nil
  @books = []
  @search_method = ''
  if @title.length > 0
    @book = Book.search_title(@title)
    @search_method = 'Title'
  elsif @author.length > 0
    @books = Book.search_author(@author)
    @search_method = 'Author'
  end
  erb(:librarian_search_results)
end

post('/patron_add') do
  name = params['name']
  new_patron = Patron.new(:name => name, :id => nil)
  new_patron.save
  @name = new_patron.name
  @id = new_patron.id
  erb(:patron_success)
end

get('/patron') do
  @books = Book.all
  erb(:patron)
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
  book.update({:in_stock => false})
  @book = book
  erb(:checkout_success)
end

patch('/return-success') do
  book_id = params.fetch('book_id').to_i
  patron_id = params.fetch('patron_id').to_i
  book.update({:in_stock => true})
  erb(:return_success)
end
