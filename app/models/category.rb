class Category
  attr_reader :id, :category_name

  def initialize(data)
    @id     = data[:id]
    @category_name   = data[:category_name]
  end
end
