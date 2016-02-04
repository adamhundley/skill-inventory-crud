require_relative '../test_helper'

class UserCanEditExistingTaskTest < Minitest::Test
  include Capybara::DSL
  include TestHelpers

  def test_user_can_delete_a_skill
    create_skills(1)
    visit '/skills'

    within ".skills" do
      assert page.has_content? "test name"
    end

    click_button("Delete")

    assert_equal '/skills', current_path

    within("body") do  #ask about this
      refute page.has_content? "test_name"
    end

  end

end
