module RequestSpecHelpers
  def auth_user(user_id='1')
    @@current_token = JsonWebToken.encode(user_id: user_id)
  end

  def auth_get(url, headers={})
    get url, params: {}, headers: headers.merge!({Authorization: @@current_token})
  end

  def auth_post(url, params, headers={})
    post url, params: params, headers: headers.merge!({Authorization: @@current_token})
  end

  def auth_put(url, params, headers={})
    put url, params: params, headers: headers.merge!({Authorization: @@current_token})
  end

  def auth_delete(url, headers={})
    delete url, params: {}, headers: headers.merge!({Authorization: @@current_token})
  end
end
