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

  test "total_pledge" do
    @project.save
    pledge1 = create(:pledge,
      dollar_amount: 100.00,
      project: @project,
  )

    pledge2 = create(:pledge,
      dollar_amount: 20.00,
      project: @project,
)
    assert_equal(120.00, @project.total_pledge)
  end

  test "goal_positive" do
    @project.goal = 0
    @project.save
    assert @project.invalid?
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
    assert_equal "12 days", @project.time_left
  end

end
