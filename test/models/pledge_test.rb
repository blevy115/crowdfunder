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

end
