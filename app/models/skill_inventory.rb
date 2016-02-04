require 'yaml/store'

class SkillInventory
  attr_reader :database

  def initialize(database)
    @database = database
  end

  def create(skill)
    database.transaction do
      database["skills"] ||= []
      database["next_id"] ||= 0
      database["next_id"] += 1
      database["skills"] << {"id" => database["next_id"],
                            "name" => skill["name"],
                            "status" => skill["status"]}
    end
  end

  def raw_skills
    database.transaction do
      database["skills"] || []
    end
  end

  def raw_skill(id)
    raw_skills.find { |skill| skill["id"] == id }
  end

  def find(id)
    Skill.new(raw_skill(id))
  end

  def all
    raw_skills.map { |skill| Skill.new(skill)}
  end

  def delete(id)
    database.transaction do
      database["skills"].delete_if { |skill| skill["id"] == id }
    end
  end

  def update(skill, id)
    database.transaction do
      target_skill = database["skills"].find { |s| s["id"] == id }
      target_skill["name"] = skill[:name]
      target_skill["status"] = skill[:status]
    end
  end

  def delete_all
    database.transaction do
      database["skills"] = []
      database["next_id"] = 0
    end
  end
end
