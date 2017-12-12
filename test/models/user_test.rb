require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @user = build(:user)
  end

  test "email must be unique" do
    @user.email = "bettymaker@gmail.com"
    @user.save
    user2 = bulid(:user)
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

  test "password must be longer than 8 characters" do
    user = build(:user, password: "1234", password_confirmation: "1234")
    refute user.valid?
  end

  test "full name displays first and last names" do
    @user.first_name = "john"
    @user.last_name = "doe"
    expected = "john doe"
    actual = @user.full_name
    assert_equal(expected, actual)
  end

  

end
