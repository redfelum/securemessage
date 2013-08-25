# coding: utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery



  def login_by_hash(a_hash)
      login_tw a_hash
  end



  def login_tw a_hash
    u = User.find_or_create_by_username(a_hash['info']["nickname"])
    u.username = a_hash['info']["nickname"]
    u.username = a_hash['info']["name"]
    u.save(:validate=>false)
    return u
  end

end
