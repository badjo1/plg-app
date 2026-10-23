module SessionTestHelper
  def sign_in_as(user, password: "password")
    post session_url, params: { email_address: user.email_address, password: password }
  end

  def sign_out
    delete session_url
  end
end
