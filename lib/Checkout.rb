class Checkout
  attr_reader(:book_id, :patron_id, :checkout_date, :id)
  attr_accessor(:due_date, :checked_out, :return_date)

  def initialize(attributes)
    @book_id = attributes.fetch(:book_id)
    @patron_id = attributes.fetch(:patron_id)
    @checkout_date = attributes.fetch(:checkout_date) ## :checkout_date and @checkout_date will both be date objects
    @due_date = @checkout_date + 27
    @id = attributes.fetch(:id)
    @checked_out = true
    @return_date = @checkout_date - 1 ## initialize @return_date to the day before checkout_date
  end

  def self.all
    returned_checkouts = DB.exec("SELECT * FROM checkouts;")
    checkouts = []
    returned_checkouts.each do |checkout|
      book_id = checkout.fetch('book_id')
      patron_id = checkout.fetch('patron_id')
      checkout_date = checkout.fetch('checkout_date')
      due_date = checkout.fetch('due_date')
      id = checkout.fetch('id')
      return_date = checkout.fetch('return_date')
      if checkout.fetch('checked_out') == 't'
        checked_out = true
      elsif checkout.fetch('checked_out') == 'f'
        checked_out = false
      end
      checkouts.push(Checkout.new({:book_id => book_id, :patron_id => patron_id, :checkout_date => checkout_date, :due_date => due_date, :id => id, :return_date => return_date, :checked_out => checked_out }))
    end
    checkouts
  end

  def ==(another_thing)
    self.book_id().==(another_thing.book_id()).&(self.patron_id().==(another_thing.patron_id())).&(self.checkout_date().==(another_thing.checkout_date()))
  end

  def save
    result = DB.exec("INSERT INTO   checkouts (book_id, patron_id, checkout_date, due_date, checked_out, return_date) VALUES (#{@book_id}, #{@patron_id}, '#{@checkout_date.to_s}', '#{@due_date.to_s}', '#{@checked_out}', '#{@return_date.to_s}') RETURNING id, book_id;")
    @id = result.first.fetch('id').to_i
    DB.exec("UPDATE books SET in_stock = FALSE WHERE id = #{@book_id};")
  end

  def self.find(book_id, patron_id) #needs updating - should only need to search by one at a time? Or do the views require this method?
    found_checkout = nil
    Checkout.all.each do |checkout|
      if checkout.book_id.==(book_id).&(checkout.patron_id.==(patron_id))
        found_checkout = checkout
      end
    end
    found_checkout
  end

  def return
    @return_date = Date.today
    @id = self.id
    DB.exec("UPDATE checkouts SET return_date = '#{@return_date.to_s}' WHERE id = #{@id};")
    DB.exec("UPDATE checkouts SET checked_out = FALSE WHERE id = #{@id}")
    DB.exec("UPDATE books SET in_stock = TRUE where id = #{@book_id}")
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
