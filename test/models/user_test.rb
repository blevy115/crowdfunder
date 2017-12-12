require 'test_helper'

class UserTest < ActiveSupport::TestCase

  setup do
    @user = build(:user)
  end


  test "email must be unique" do
    @user.email = 'test@test.com'
    @user.save
    user2 = build(:user)
    user2.email = 'test@test.com'
    refute user2.valid?
  end

  test "user must include password_confirmation on create" do
    @user.password_confirmation = nil
    refute @user.valid?
  end

  test "password must match confirmation" do
    @user.password_confirmation = @user.password.reverse
    refute @user.valid?
  end

  test "password must be at least 8 characters long" do
    @user.password = "1234"
    @user.password_confirmation = @user.password
    refute @user.valid?
  end

  test "full name displays first and last name" do
    @user.first_name = "John"
    @user.last_name = "Doe"
    expected = "John Doe"
    actual = @user.full_name
    assert_equal(expected, actual)
  end

  test "full name displays none if first and last name empty" do
    expected = " "
    actual = @user.full_name
    assert_equal(expected, actual)
  end

  test "new project with an owner" do
    project = build(:project)
    assert project.user.valid?
  end
end
