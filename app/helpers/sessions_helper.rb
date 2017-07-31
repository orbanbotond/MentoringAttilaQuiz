module SessionsHelper

  def set_username_default(username)
    if User.username_present?(username)
      username
    else
      nil
    end
  end

  def set_error_message(username)
    if username.present?
      if User.username_present?(username)
        "Invalid password"
      else 
        "Invalid username"
      end
    end
  end

end
