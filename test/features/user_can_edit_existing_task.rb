require_relative '../test_helper'

class UserCanEditExistingTaskTest < Minitest::Test
  include Capybara::DSL
  include TestHelpers

  def test_user_can_edit_a_skill
    create_skills(1)
    visit '/skills/1/edit'

    assert_equal '/skills/1/edit', current_path

    fill_in "skill[name]", :with => "Freaking Skill"
    fill_in "skill[status]", :with => "dope"
    click_button("Submit")

    assert_equal '/skills', current_path

    within(".skills") do
      assert page.has_content? "Freaking Skill"
    end
  end
end
