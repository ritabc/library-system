class Patron
  attr_reader(:name, :id)

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  def ==(another_thing)
    self.name().==(another_thing.name())
  end

  def save
    result = DB.exec("INSERT INTO patrons (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first.fetch('id').to_i
  end

  def self.all
    returned_patrons = DB.exec("SELECT * FROM patrons;")
    patrons = []
    returned_patrons.each do |patron|
      name = patron.fetch('name')
      id = patron.fetch('id')
      patrons.push(Patron.new({:name => name, :id => id}))
    end
    patrons
  end

end
