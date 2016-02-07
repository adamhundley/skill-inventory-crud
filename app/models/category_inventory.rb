class CategoryInventory

attr_reader :database
  def initialize(database)
    @database = database
  end

  def dataset
    database.from(:categories)
  end

  def create(category)
    dataset.insert(category)
  end

  def all
    dataset.map { |category| Category.new(category)}
  end

end
