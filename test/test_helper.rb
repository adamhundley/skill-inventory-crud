ENV["RACK_ENV"] ||= "test"

require File.expand_path('../../config/environment', __FILE__)
require 'minitest/autorun'
require 'minitest/pride'
require 'capybara/dsl'
require 'tilt/erb'

DatabaseCleaner[:sequel, {:connection => Sequel.sqlite("db/skill_inventory_test.sqlite3")}].strategy = :truncation

module TestHelpers

  def setup
    DatabaseCleaner.start
    super
  end

  def teardown
    DatabaseCleaner.clean
    super
  end

  def skill_inventory
    database = Sequel.sqlite("db/skill_inventory_test.sqlite3")
    @skill_inventory ||= SkillInventory.new(database)
  end

  def create_skills(number)
    number.times do |i|
    skill_inventory.create(
      name:       "name#{i+1}",
      description: "description#{i+1}",
      status:      "status#{i+1}")
    end
  end
end

Capybara.app = SkillInventoryApp
Capybara.save_and_open_page_path = "tmp/capybara"

class FeatureTest < Minitest::Test
  include Capybara::DSL
  include TestHelpers
end
