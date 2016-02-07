
class SkillInventory
  attr_reader :database

  def initialize(database)
    @database = database
  end

  def joined_tables
    dataset.join(:categories, :id => :category_id)
  end

  def dataset
    database.from(:skills)
  end

  def create(skill)
    dataset.insert(skill)
  end

  def find(id)
    data = dataset.where(:id => id).to_a.first
    Skill.new(data)
  end

  def all
    dataset.map { |skill| Skill.new(skill) }
  end

  def delete(id)
    dataset.where(:id => id).delete
  end

  def update(skill, id)
    dataset.where(:id => id).update(skill)
  end
end
