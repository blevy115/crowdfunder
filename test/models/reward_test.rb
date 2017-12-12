require 'test_helper'

class RewardTest < ActiveSupport::TestCase

  test 'A reward can be created' do
    reward = create(:reward)
    assert reward.valid?
    assert reward.persisted?
  end

  test 'A reward cannot be created without a dollar amount' do
    reward = build(:reward, dollar_amount: nil)
    assert reward.invalid?, 'Reward should be invalid without dollar amount'
    assert reward.new_record?, 'Reward should not save without dollar amount'
  end

  test 'A reward cannot be created without a description' do
    reward = build(:reward, description: nil)
    assert reward.invalid?, 'Reward should be invalid without a description'
    assert reward.new_record?, 'Reward should not save without a description'
  end

  def test_reward_positive
  reward = build(:reward, dollar_amount: 0)
    assert reward.invalid?
  end

end
