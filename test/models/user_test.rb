require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "email must be unique" do
    user = User.create(email: "bettymaker@gmail.com", password: "12345678", password_confirmation: "12345678")
    user2 = User.new(email: "bettymaker@gmail.com", password: "00000000", password_confirmation: "00000000")
    refute user2.valid?
  end

  test "user must include password_confirmation on create" do
    user = User.new(email: "bettymaker@gmail.com", password: "12345678")
    refute user.valid?
  end

  test "password must match confirmation" do
    user = User.new(email: "bettymaker@gmail.com", password: "12345678", password_confirmation: "87654321")
    refute user.valid?
  end

  test "password must be at least 8 characters long" do
    user = User.new(email: "bettymaker@gmail.com", password: "1234", password_confirmation: "1234")
    refute user.valid?
  end

  test "full name displays first and last name" do
    user = User.new(first_name: "John", last_name: "Doe")
    expected = "John Doe"
    actual = user.full_name
    assert_equal(expected, actual)
  end

  test "full name displays none if first and last name empty" do
    user = User.new
    expected = " "
    actual = user.full_name
    assert_equal(expected, actual)
  end

  test "new project with an owner" do
    user = User.create(
      first_name: "John",
      last_name: "Doe",
      email: "johndoe@gmail.com",
      password: "password",
      password_confirmation: "password"
    )
    project = Project.new(
      title: "The test project",
      description: Faker::Lorem.paragraph,
      goal: 90_000,
      start_date: Time.now.utc - rand(60).days,
      end_date: Time.now.utc + rand(10).days,
      user_id: user.id
    )
    user.admin = true

    assert project.user.valid?

  end
end
