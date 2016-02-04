require_relative '../test_helper'

class SkillTest < Minitest::Test
  def test_task_instantiates
    data = {"name"       => "name",
            "id"          => 1,
            "status" => "this is a status"}

    skill = Skill.new(data)

    assert skill.instance_of?(Skill)
  end

  def test_assigns_attributes_correctly
    data = {"name"       => "name",
            "id"          => 1,
            "status" => "this is a status"}

    skill = Skill.new(data)

    assert_equal "name", skill.name
    assert_equal "this is a status", skill.status
    assert_equal 1, skill.id
  end

end
