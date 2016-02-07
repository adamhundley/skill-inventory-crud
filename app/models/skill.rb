class Skill
  attr_reader :id, :name, :status, :category_id, :category

  def initialize(data)
    @id     = data[:id]
    @name   = data[:name]
    @status = data[:status]
    @category_id = data[:category_id]
    # @category = data[:category]
  end
end
