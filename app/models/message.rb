require 'gibberish'

class Message < ActiveRecord::Base
   attr_accessible :message_text
   before_create :encrupt_message

  def encrupt_message
    cipher = Gibberish::AES.new(@pass_id)
    self.message_text=  cipher.enc(self.message_text)
    self.short_url = SecureRandom.hex(5)
   end

   def set_password(params)
    @pass_id=params
   end

   def self.decrupt_message(messages,password)
     cipher = Gibberish::AES.new(password)
     msg = cipher.dec(messages)
   end

end
