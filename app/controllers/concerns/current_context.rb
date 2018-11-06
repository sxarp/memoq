module CurrentContext
  def current_user_id
    session[:_current_user_id]
  end
end
