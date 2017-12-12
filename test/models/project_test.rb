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

   test "total pledge" do
     @project.save
     pledge1 = create(:pledge, dollar_amount: 99.00, project: @project)
     pledge2 = create(:pledge, dollar_amount: 99.00, project: @project)
     expected = 198.00
      actual = @project.total_pledge
     assert_equal(expected, actual)
  end

  test "goal positive" do
    @project.goal = 0
    @project.save
    refute @project.valid?
  end

  test "new projects for a category" do
    category = build(:category)
    assert category.valid?
    refute_nil category.projects
  end

  test "many projects for catagories" do
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


end
