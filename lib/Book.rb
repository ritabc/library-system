class Book
  attr_reader(:id)
  attr_accessor(:title, :author, :author_id, :in_stock)

  def initialize(attributes)
    @title = attributes.fetch(:title)
    @author = attributes.fetch(:author)
    @id = attributes.fetch(:id)
    if attributes.has_key?(:in_stock)
      @in_stock = attributes.fetch(:in_stock)
    else
      @in_stock = true
    end
  end

  def ==(another_thing)
    self.title.==(another_thing.title).&(self.author.==(another_thing.author))
  end

  def save
    result = DB.exec("INSERT INTO books (title, author, in_stock) VALUES ('#{@title}', '#{@author}', TRUE) RETURNING id;")
    @id =  result.first.fetch('id').to_i
  end

  def self.all
    returned_books = DB.exec("SELECT * FROM books;")
    books = []
    returned_books.each() do |book|
      title = book.fetch('title')
      author = book.fetch('author')
      id = book.fetch('id').to_i()
      if book.fetch('in_stock') == 't'
        in_stock = true
      elsif book.fetch('in_stock') == 'f'
        in_stock = false
      end
      books.push(Book.new({:title => title, :author => author, :id =>id, :in_stock => in_stock}))
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

  def self.find(id)
      found_book = nil
      Book.all.each do |book|
        if book.id.==(id)
          found_book = book
        end
      end
      found_book
    end

  def update(attributes)
    @title = attributes.fetch(:title, @title)
    @author = attributes.fetch(:author, @author)
    @in_stock = attributes.fetch(:in_stock, @in_stock)
    @id = self.id
    if @title.length > 0
      DB.exec("Update books SET title = '#{@title}' WHERE id = #{@id}")
    end
    if @author.length > 0
      DB.exec("Update books SET author = '#{@author}' WHERE id = #{@id}")
    end
  end

  def delete
    DB.exec("DELETE FROM books WHERE ID = #{self.id()};")
  end

  def in_stock?
    result = DB.exec("SELECT in_stock FROM books WHERE id = #{self.id};")
    if result.first.fetch("in_stock") == 't'
      true
    else
      false
    end
  end

  def in_stock_update
    ## check the books table at id = @id
    ## if in_Stock = false, update @in_stock
    results = DB.exec("SELECT in_stock FROM books WHERE id = #{@id};")
    new_in_stock_value = results.first.fetch('in_stock')
    DB.exec("UPDATE books SET in_stock = #{new_in_stock_value};")
  end
end
