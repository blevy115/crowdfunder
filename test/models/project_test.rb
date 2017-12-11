require 'test_helper'

class ProjectTest < ActiveSupport::TestCase

  test 'valid project can be created' do
    owner = new_user
    owner.save
    project = new_project
    project.user = owner
    project.save
    assert project.valid?
    assert project.persisted?
    assert project.user
  end

  test 'project is invalid without owner' do
    project = new_project
    project.user = nil
    project.save
    assert project.invalid?, 'Project should not save without owner.'
  end

  def test_total_pledge
    owner = new_user
    owner.save
    project = new_project
    project.user = owner
    project.save
    pledger = another_user
    pledger.save
    pledge1 = Pledge.create(
      dollar_amount: 99.00,
      project: project,
      user: pledger
    )
    pledge2 = Pledge.create(
      dollar_amount: 99.00,
      project: project,
      user: pledger
    )
    expected = 198.00
    actual = project.total_pledge
    assert_equal(expected, actual)
  end

  def test_goal_positive
    owner = new_user
    owner.save
    project = Project.new(
      title:       'Cool new boardgame',
      description: 'Trade sheep',
      start_date:  Date.today,
      end_date:    Date.today + 1.month,
      goal:        0
    )
    project.user = owner
    project.save
    refute project.valid?
  end

  def test_project_many_categories
    owner = new_user
    owner.save
    project = new_project
    project.user = owner
    project.save
    category1 = new_category
    category2 = another_category
    category1.save
    category2.save
    project.categories << category1
    project.categories << category2
    assert project.valid?
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

  def new_user
    User.new(
      first_name:            'Sally',
      last_name:             'Lowenthal',
      email:                 'sally@example.com',
      password:              'passpass',
      password_confirmation: 'passpass'
    )
  end

  def another_user
    User.new(
      first_name:            'James',
      last_name:             'Lowenthal',
      email:                 'james@example.com',
      password:              'passpass',
      password_confirmation: 'passpass'
    )
  end

  def new_category
    Category.new(
      tag: "Art"
    )
  end

  def another_category
    Category.new(
      tag: "Music"
    )
  end
end
