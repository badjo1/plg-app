require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "normalizes the email address" do
    user = User.new(email_address: "  New@Example.COM ")
    assert_equal "new@example.com", user.email_address
  end

  test "finds users by a non-normalized email address" do
    assert_equal users(:one), User.find_by(email_address: " ONE@example.com")
  end

  test "requires a password" do
    user = User.new(email_address: "new@example.com")
    assert_not user.valid?
    assert user.errors.of_kind?(:password, :blank)
  end

  test "requires the password confirmation to match" do
    user = User.new(email_address: "new@example.com", password: "secret123", password_confirmation: "other")
    assert_not user.valid?
    assert user.errors.of_kind?(:password_confirmation, :confirmation)
  end

  test "requires an email address" do
    user = User.new(password: "secret123")
    assert_raises(ActiveRecord::NotNullViolation) { user.save }
  end

  test "rejects a duplicate email address" do
    user = User.new(email_address: " ONE@example.com", password: "secret123")
    assert_not user.valid?
    assert user.errors.of_kind?(:email_address, :taken)
  end

  test "authenticates by email address and password" do
    assert_equal users(:one), User.authenticate_by(email_address: "one@example.com", password: "password")
    assert_nil User.authenticate_by(email_address: "one@example.com", password: "wrong")
    assert_nil User.authenticate_by(email_address: "nobody@example.com", password: "password")
  end

  test "destroys its sessions when destroyed" do
    user = users(:one)
    user.sessions.create!

    assert_difference("Session.count", -user.sessions.count) do
      user.destroy
    end
  end

  test "password reset token resolves to the user" do
    user = users(:one)
    assert_equal user, User.find_by_password_reset_token!(user.password_reset_token)
  end

  test "password reset token expires" do
    token = users(:one).password_reset_token

    travel 16.minutes do
      assert_raises(ActiveSupport::MessageVerifier::InvalidSignature) do
        User.find_by_password_reset_token!(token)
      end
    end
  end
end
