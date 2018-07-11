class Checkout
  attr_reader(:book_id, :patron_id, :checkout_date)
  attr_accessor(:due_date)

  def initialize(attributes)
    @book_id = attributes.fetch(:book_id)
    @patron_id = attributes.fetch(:patron_id)
    @checkout_date = attributes.fetch(:checkout_date) ## :checkout_date and @checkout_date will both be date objects
    @due_date = @checkout_date + 27
  end
end
