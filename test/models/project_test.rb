require 'test_helper'

class ProjectTest < ActiveSupport::TestCase

  test 'valid project can be created' do
    project = create(:project)
    assert project.valid?
    assert project.persisted?
    assert project.user
  end

  test 'project is invalid without owner' do
    project = build(:project, user: nil)
    assert project.invalid?, 'Project should not save without owner.'
  end

  def test_total_pledge
    project = create(:project)
    pledge1 = create(:pledge, project: project)
    pledge2 = create(:pledge, project: project)
    expected = 40
    actual = project.total_pledge
    assert_equal(expected, actual)
  end

  def test_goal_positive
    project = build(:project, goal: 0)
    refute project.valid?
  end

  def test_project_many_categories
    project = create(:project)
    category1 = create(:category, tag: 'Art')
    category2 = create(:category, tag: 'Music')
    project.categories << category1
    project.categories << category2
    assert project.valid?
  end

  test 'time left displays days left' do
    project = create(:project)
    expected = "1 day"
    actual = project.time_left
    assert_equal expected, actual
  end

end
