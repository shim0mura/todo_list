class User < ActiveRecord::Base
  attr_accessor :password
  before_save :encrypt_password

  def encrypt_password
    if password.present?
      salt = BCrypt::Engine.generate_salt
      encrypted_password = BCrypt::Engine.hash_secret(password, salt)
    end
  end
end
