class Checkout
  attr_reader(:book_id, :patron_id, :checkout_date, :id)
  attr_accessor(:due_date)

  def initialize(attributes)
    @book_id = attributes.fetch(:book_id)
    @patron_id = attributes.fetch(:patron_id)
    @checkout_date = attributes.fetch(:checkout_date) ## :checkout_date and @checkout_date will both be date objects
    @due_date = @checkout_date + 27
    @id = attributes.fetch(:id)
  end
  def ==(another_thing)
    self.book_id().==(another_thing.book_id()).&(self.patron_id().==(another_thing.patron_id())).&(self.checkout_date().==(another_thing.checkout_date()))
  end

  def save
    result = DB.exec("INSERT INTO checkouts (book_id, patron_id, checkout_date, due_date) VALUES (#{@book_id}, #{@patron_id}, '#{@checkout_date}', '#{@due_date}' ) RETURNING id, book_id;")
    @id = result.first.fetch('id').to_i
    # @book_id = result.first.fetch('book_id').to_i
    in_stock = DB.exec("UPDATE books SET in_stock = FALSE WHERE id = #{@book_id} RETURNING in_stock;")
    # if in_stock.first.fetch('id') == 't'
    #   true
    # else
    #   false
  end


  # def self.search_by_patron
  #   search_result = DB.exec("SELECT * FROM checkouts WHERE patron_id = #{@patron_id};")
  #   check_outs = []
  #   search_result.each do |checkout|
  #     book_id = checkout.fetch('book_id')
  #     checkout_date = checkout.fetch('checkout_date')
  #     id = checkout.fetch('id')
  #     due_date = checkout.fetch('due_date')
  #     check_outs.push(Checkout.new({:book_id => book_id, :patron_id => @patron_id, :checkout_date => checkout_date, :id => id, :due_date => due_date}
  #   end
  #   books = {}
  #   check_outs.each do |checkout| ## now get book title and author for each check_out
  #     result_book = DB.exec("SELECT * FROM books WHERE id = #{checkout.book_id}")
  #     title = result_book.fetch('title')
  #     author = result_book.fetch('author')
  #     books.store()
  #   end
end
