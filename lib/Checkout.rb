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
    result = DB.exec("INSERT INTO checkouts (book_id, patron_id, checkout_date, due_date) VALUES (#{@book_id}, #{@patron_id}, '#{@checkout_date}', '#{@due_date}' ) RETURNING id;")
    @id = result.first.fetch('id').to_i
  end

end
