require_relative '../test_helper'

class PledgeTest < ActiveSupport::TestCase

  setup do
    @pledge = build(:pledge)
    @project = @pledge.project
  end

  test 'A pledge can be created' do
    @pledge.save
    assert @pledge.valid?
    assert @pledge.persisted?
  end

  test 'owner cannot back own project' do
    @pledge.user = @project.user
    @pledge.save
    assert @pledge.invalid?, 'Owner should not be able to pledge towards own project'
  end

  test 'total shows sum of pledges for all projects' do
    5.times do
      create(:pledge)
    end
    2.times do
      create(:pledge, dollar_amount: 100)
    end
    expected = 250
    actual = Pledge.total
    assert_equal expected, actual
  end

  test 'total shows 0 when no pledges' do
    expected = 0
    actual = Pledge.total
    assert_equal expected, actual
  end

end
