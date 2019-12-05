class SecretBox
  require "base64"

  def self.decrypt(encoded_message)
    prefix = Base64.encode64(nonce).strip
    ciphertext = Base64.decode64(encoded_message.delete_prefix(prefix))
    secret_box.decrypt(nonce, ciphertext).strip
  end

  def self.encrypt(message)
    Base64.encode64(nonce + secret_box.encrypt(nonce, message))
      .strip
      .delete!("\n")
  end

  def self.key
    key ||= ENV['STREAMING_CLIENT_SECRET'].encode('BINARY')
  end

  def self.secret_box
    secret_box ||= RbNaCl::SecretBox.new(key)
  end

  def self.nonce
    nonce ||= ENV['STREAMING_CLIENT_ID']
  end
end
