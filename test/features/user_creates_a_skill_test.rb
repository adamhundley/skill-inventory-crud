require_relative '../test_helper'

class UserCreatesASkillTest < FeatureTest
  include Capybara::DSL
  include TestHelpers

  def test_user_can_create_a_skill
    category_inventory.create(category_name: "Work")
    category_inventory.create(category_name: "Play")

    visit '/skills/new'

    fill_in "skill[name]", :with => "Freaking Skill"
    fill_in "skill[status]", :with => "dope"

    select "Work", from: "category_id"

    click_button "Submit"
    assert_equal '/skills', current_path

    within(".skills") do
      assert page.has_content? "Freaking Skill"
      assert page.has_content? "Work"
    end
    refute page.has_content? "Play"
  end
end
