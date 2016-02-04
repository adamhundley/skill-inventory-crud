require_relative '../test_helper'

class UserCreatesASkillTest < Minitest::Test
  include Capybara::DSL
  include TestHelpers

  def test_user_can_create_a_skill
    visit '/'
    click_link "New Skill"

    assert_equal '/skills/new', current_path

    fill_in "skill[name]", :with => "Freaking Skill"
    fill_in "skill[status]", :with => "dope"
    click_button("Submit")

    assert_equal '/skills', current_path

    within(".skills") do
      assert page.has_content? "Freaking Skill"
    end

  end

end
