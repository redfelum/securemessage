module MessagesHelper
  @message
  def decrupt_message(messages,password)
    cipher = Gibberish::AES.new(password)
    msg = cipher.dec(messages)
  end

  def init_msg(message)
    @message=message
  end

  def get_message
    @message
  end

end
