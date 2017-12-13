require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
  @user = build(:user)
  end

  test "email must be unique" do

    user1 = create(:user, email: "bettymaker@gmail.com")
    user2 = build(:user, email: "bettymaker@gmail.com")
    refute user2.valid?
  end

  test "user must include password_confirmation on create" do
    user = build(:user)
    assert user.password_confirmation
  end

  test "password must match confirmation" do
    assert_equal(@user.password, @user.password_confirmation)
  end

  test "password must be at least 8 characters long" do
    user = build(:user, password:"1234567")
    assert user.invalid?
  end

  test "full name displays first and last name" do
    user = build(:user, first_name: "foo", last_name: "bar")
    assert_equal("foo bar", user.full_name)
  end

  test "full name displays none if first and last name empty" do
    user = build(:user, first_name: "",last_name: "" )
    expected = " "
    actual = user.full_name
    assert_equal(expected, actual)
  end


end
