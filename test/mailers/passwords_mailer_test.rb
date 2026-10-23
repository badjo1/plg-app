require "test_helper"

class PasswordsMailerTest < ActionMailer::TestCase
  setup do
    @user = users(:one)
  end

  test "reset" do
    mail = PasswordsMailer.reset(@user)

    assert_equal "Reset your password", mail.subject
    assert_equal [ @user.email_address ], mail.to
    assert_equal [ "from@example.com" ], mail.from
  end

  test "reset contains a working reset link in both parts" do
    mail = PasswordsMailer.reset(@user)

    [ mail.html_part, mail.text_part ].each do |part|
      token = part.body.to_s[%r{/passwords/([^/]+)/edit}, 1]
      assert token, "expected a reset link in the #{part.mime_type} part"
      assert_equal @user, User.find_by_password_reset_token!(CGI.unescape(token))
    end
  end
end
