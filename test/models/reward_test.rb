require 'test_helper'

class RewardTest < ActiveSupport::TestCase

  setup do
    @project = create(:project)
    @reward = build(:reward, project: @project)
  end

  test 'A reward can be created' do
    @reward.save
     assert @reward.valid?
     assert @reward.persisted?
  end

  test 'A reward cannot be created without a dollar amount' do
    @reward.dollar_amount = nil
     @reward.save
     assert @reward.invalid?, 'Reward should be invalid without dollar amount'
     assert @reward.new_record?, 'Reward should not save without dollar amount'
  end

  test 'A reward cannot be created without a description' do
     @reward.description = nil
     @reward.save
     assert @reward.invalid?, 'Reward should be invalid without a description'
     assert @reward.new_record?, 'Reward should not save without a description'
  end

  test 'reward is positive' do
   @reward.dollar_amount = 0
   @reward.save
   assert @reward.invalid?
  end

end
