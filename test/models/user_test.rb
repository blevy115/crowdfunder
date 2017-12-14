require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @user = build(:user)
  end

  test "email must be unique" do
    @user.email = "bettymaker@gmail.com"
    @user.save
    user2 = build(:user)
    user2.email = "bettymaker@gmail.com"
    refute user2.valid?
  end

  test "user must include password_confirmation on create" do

    user = build(:user, password: "12345678")
    refute user.valid?
  end

  test "password must match confirmation" do
    user = build(:user, password: "12345678", password_confirmation: "87654321")
    refute user.valid?
  end


  test "password must be at least 8 characters long" do
    user = build(:user, password: "1234", password_confirmation: "1234")
    refute user.valid?
  end


  test "full name displays first and last name" do
    @user.first_name = "John"
    @user.last_name = "Doe"
    expected = "John Doe"
    actual = @user.full_name
    assert_equal(expected, actual)
  end


  test "full name displays none if first and last name empty" do
    user = build(:user, first_name: "",last_name: "" )
    expected = " "
    actual = @user.full_name
    assert_equal(expected, actual)
  end

  test "new project with an owner is an admin" do
    project = build(:project)
    assert project.user.valid?
    assert project.user.admin
  end

  test "total_pledges_calculate_correctly" do
    @user = create(:user, first_name: "",last_name: "" )
    @pledge1 = create(:pledge)
    @user.pledges << @pledge1
    @pledge2 = create(:pledge)
    @user.pledges << @pledge2
    expected = 20
    actual = @user.total_of_pledge
    assert_equal(expected, actual)
  end

  test "total_rewards_calculate_correctly" do
    @user = create(:user, first_name: "",last_name: "" )
    @project1 = create(:project, title: "1")
    @project2 = create(:project, title: "2")
    @reward1 = create(:reward, project: @project1, dollar_amount: 20)
    @reward2 = create(:reward, project: @project1, dollar_amount: 40)
    @reward3 = create(:reward, project: @project2, dollar_amount: 50)
    @reward4 = create(:reward, project: @project2, dollar_amount: 70)
    @user.rewards << @reward1
    @user.rewards << @reward2
    @user.rewards << @reward3
    @user.rewards << @reward4
    expected = {"1" => 60, "2" => 120}
    actual = @user.total_rewards
    assert_equal(expected, actual)
  end

  test "reward_hash_number" do
    @user = create(:user, first_name: "",last_name: "" )
    @reward1 = create(:reward, project: @project1, dollar_amount: 20)
    @reward2 = @reward1
    @reward3 = @reward1
    @reward4 = create(:reward, project: @project2, dollar_amount: 20)
    @user.rewards << @reward1
    @user.rewards << @reward2
    @user.rewards << @reward3
    @user.rewards << @reward4
    expected = {@reward1 => 3, @reward4 => 1}
    actual = @user.reward_hash
    assert_equal(expected, actual)
  end


end
