require 'test_helper'

class CategoryTest < ActiveSupport::TestCase

  def test_category_many_products
    owner = new_user
    owner.save
    project1 = new_project
    project1.user = owner
    project1.save
    project2 = new_project
    project2.user = owner
    project2.save
    category = new_category
    category.save
    category.projects << project1
    category.projects << project2
    assert category.valid?
  end

  def new_category
    Category.new(
      tag: "Art"
    )
  end

  def new_user
    User.new(
      first_name:            'Sally',
      last_name:             'Lowenthal',
      email:                 'sally@example.com',
      password:              'passpass',
      password_confirmation: 'passpass'
    )
  end

  def new_project
    Project.new(
      title:       'Cool new boardgame',
      description: 'Trade sheep',
      start_date:  Date.today,
      end_date:    Date.today + 1.month,
      goal:        50000
    )
  end

  def another_project
    Project.new(
      title:       'Cool new videogame',
      description: 'Save Hyrule',
      start_date:  Date.today,
      end_date:    Date.today + 1.month,
      goal:        50000
    )
  end
end
