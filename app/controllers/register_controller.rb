# coding: utf-8
class RegisterController < ApplicationController
  def callback
    #    raise request.env["omniauth.auth"].to_yaml
    auth_hash = request.env['omniauth.auth']
    user = login_by_hash(auth_hash)
    sign_in user
    redirect_to root_path

  end

  def failure
  end

  def logout
  end
end
