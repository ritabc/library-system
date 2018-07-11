class Book
  attr_reader(:id)
  attr_accessor(:title, :author, :author_id)

  def initialize(attributes)
    @title = attributes.fetch(:title)
    @author = attributes.fetch(:author)
    @id = attributes.fetch(:id)
  end

  def ==(another_thing)
    self.title().==(another_thing.title()).&(self.author().==(another_thing.author()))
  end

  def save
    result = DB.exec("INSERT INTO books (title, author) VALUES ('#{@title}', '#{@author}') RETURNING id;")
    @id = result.first.fetch('id').to_i
  end

  def self.all
    returned_books = DB.exec("SELECT * FROM books;")
    books = []
    returned_books.each() do |book|
      title = book.fetch('title')
      author = book.fetch('author')
      id = book.fetch('id').to_i()
      books.push(Book.new({:title => title, :author => author, :id =>id}))
    end
    books
  end

  def self.search_title(title)
    search_result = DB.exec("SELECT * FROM books WHERE title = '#{title}';")
    books = []
    search_result.each() do |book|
      title = book.fetch('title')
      author = book.fetch('author')
      id = book.fetch('id').to_i()
      books.push(Book.new({:title => title, :author => author, :id =>id, :author_id => nil}))
    end
    books.first
  end

  def self.search_author(author)
    search_result = DB.exec("SELECT * FROM books WHERE author = '#{author}';")
    books = []
    search_result.each() do |book|
      title = book.fetch('title')
      author = book.fetch('author')
      id = book.fetch('id').to_i()
      books.push(Book.new({:title => title, :author => author, :id =>id, :author_id => nil}))
    end
    books.first
  end


  def update(attributes)
    @title = attributes.fetch(:title)
    @author = attributes.fetch(:author)
    @id = self.id
    DB.exec("Update books SET title = '#{@title}' WHERE id = #{@id}")
    DB.exec("Update books SET author = '#{@author}' WHERE id = #{@id}")
  end

  def delete
    DB.exec("DELETE FROM books WHERE ID = #{self.id()};")
  end

end
