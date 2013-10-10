class User < ActiveRecord::Base
  # Remember to create a migration!
  include BCrypt #include BCrypt's library
  
  #your validations
  validates :email, uniqueness: true
  validates :email, presence: true
  validates :password, format: {with: /\S{6,}/}


  #common BCrypt authentication method, matches login email, passowrd
  #with databse email and passowrd
  
  def self.authenticate(email, password)
    user = User.where(email: email)
    return user if user && user.password == password
    return nil
  end

  #takes a new password and then encrypts it, but also sets it to user password
  def password=(new_password)
    @passowrd = Password.create(new_password)
    self.password_hash = @password
  end

  #if there isn't a password already, created a new password object wiht password_hash
  def password
    @password ||= Password.new(password_hash)
  end

end
