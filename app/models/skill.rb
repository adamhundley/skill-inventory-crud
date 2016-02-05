class Skill
  attr_reader :id, :name, :status, :description

  def initialize(data)
    @id     = data[:id]
    @name   = data[:name]
    @status = data[:status]
    @description = data[:description]
  end
end
