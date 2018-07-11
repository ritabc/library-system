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


  def update(attributes)
    @title = attributes.fetch(:title)
    @author = attributes.fetch(:author)
    @id = self.id
    DB.exec("Update books SET title = '#{@title}' WHERE id = #{@id}")
    DB.exec("Update books SET author = '#{@author}' WHERE id = #{@id}")
  end
end
