require 'test_helper'

class ProjectTest < ActiveSupport::TestCase


  setup do
    @project = build(:project)
  end


  test 'valid project can be created' do
    @project.save
    assert @project.valid?
    assert @project.persisted?
    assert @project.user
  end

  test 'project is invalid without owner' do
    @project.user = nil
    @project.save
    assert @project.invalid?, 'Project should not save without owner.'
  end

  test 'total pledge' do
    @project.save
    pledge1 = create(:pledge,
      dollar_amount: 99.00,
      project: @project,
    )
    pledge2 = create(:pledge,
      dollar_amount: 99.00,
      project: @project,
    )
    expected = 198.00
    actual = @project.total_pledge
    assert_equal(expected, actual)
  end

  test 'goal positive' do
    @project.goal = 0
    @project.save
    refute @project.valid?
  end


  test 'new category has many projects' do
    category = build(:category)
    assert category.valid?
    refute_nil category.projects
  end

  test 'project many categories' do
    @project.save
    category1 = create(:category, tag: "movie")
    category2 = create(:category, tag: "game")
    @project.categories << category1
    @project.categories << category2
    assert @project.valid?
  end

  test 'time left displays days left' do
    @project.save

    expected = "about 1 month"
    actual = @project.time_left
    assert_equal expected, actual
  end

  test 'total live projects show how many started' do
    15.times do
      create(:project)
    end
    expected = 15
    actual = Project.total_live
    assert_equal expected, actual
  end

  test 'total live does not count projects not started' do
    @project.start_date = DateTime.now.utc + 5.days
    @project.save
    expected = 0
    actual = Project.total_live
    assert_equal expected, actual
  end

  test 'total live does not count projects ended' do
    @project.start_date = DateTime.now.utc - 1.month
    @project.end_date = DateTime.now.utc - 5.days
    @project.save
    expected = 0
    actual = Project.total_live
    assert_equal expected, actual
  end

  test 'total funded show those has reached past goal' do
    @project.goal = 10_000
    @project.save
    3.times do
      create(:pledge, project: @project, dollar_amount: 5_000)
    end
    expected = 1
    actual = Project.total_funded
    assert_equal expected, actual
  end

  test 'total funded does not add ones not reach goal' do
    @project.goal = 10_000
    @project.save
    create(:pledge, project: @project, dollar_amount: 5_000)
    expected = 0
    actual = Project.total_funded
    assert_equal expected, actual
  end

end
