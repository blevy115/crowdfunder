require 'test_helper'

class CategoryTest < ActiveSupport::TestCase

  setup do
    @project = create(:project)
    @project2 = create(:project, user: @project.user)
    @category = create(:category, tag: 'Art')
  end

  test 'category many projects' do
    @category.projects << @project
    @category.projects << @project2
    assert @category.valid?
  end

end
