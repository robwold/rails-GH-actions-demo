require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.create(first_name: 'Bob', surname: 'Kazymackis')
    @fullname = "Bob Kazymackis"
  end

  test "a user has a full name" do
    assert_equal @fullname, @user.full_name
  end

  test "we can find a user by their full name" do
    found_user = User.find_by_full_name(@fullname)
    assert_equal @user, found_user
  end
end
