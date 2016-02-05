require_relative '../test_helper'

class SkillInventoryTest < Minitest::Test
  include TestHelpers

  def test_can_create_a_skill
    create_skills(1)

    skill = skill_inventory.all.first

    assert skill.id
    assert_equal "name1", skill.name
    assert_equal "status1", skill.status
    assert_equal "description1", skill.description
  end

  def test_can_return_all_skills
    create_skills(3)

    all = skill_inventory.all

    assert_equal 3, all.count
    assert_equal Skill, all.first.class
  end

  def test_can_find_specific_skill_from_id
    create_skills(3)

    id = skill_inventory.all.last.id

    skill = skill_inventory.find(id)

    assert_equal id, skill.id
    assert_equal "name3", skill.name
    assert_equal "status3", skill.status
    assert_equal "description3", skill.description
  end

  def test_can_update_specific_skill
    create_skills(3)

    new_data = {name:         "not name",
                status:  "not some status"}

    skill_id = skill_inventory.all.first.id

    skill = skill_inventory.find(skill_id)

    assert_equal "name1", skill.name
    assert_equal "status1", skill.status

    skill_inventory.update(new_data, skill_id)
    skill = skill_inventory.find(skill_id)

    assert_equal "not name", skill.name
    assert_equal "not some status", skill.status
  end

  def test_can_delete_specific_skill
    create_skills(10)

    skill_id = skill_inventory.all.last.id

    assert_equal 10, skill_inventory.all.count

    skill_inventory.delete(skill_id)

    assert_equal 9, skill_inventory.all.count
  end
end
