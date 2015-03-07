class User < ActiveRecord::Base

  has_many :devices


#  def fullname
#    "#{self.firstname} #{self.lastname}"
#  end
#
#  def name
#    if self.firstname.blank? and self.lastname.blank?
#      "User #{self.id}"
#    elsif self.lastname.blank?
#      self.firstname
#    elsif self.firstname.blank?
#      self.lastname
#    else
#      "#{self.firstname} #{self.lastname[0,1]}."
#    end
#  end

#  # Returns the hash digest of the given string.
#  def User.digest(string)
#    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
#                                                  BCrypt::Engine.cost
#    BCrypt::Password.create(string, cost: cost)
#  end
#
#  # Returns a random token.
#  def User.new_token
#    SecureRandom.urlsafe_base64
#  end

  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

#  # Returns true if the given token matches the digest.
#  def authenticated?(attribute, token)
#    digest = send("#{attribute}_digest")
#    return false if digest.nil?
#    BCrypt::Password.new(digest).is_password?(token)
#  end

  # Forgets a user.
#  def forget
#    update_attribute(:remember_digest, nil)
#  end

#  def activate
#    update_attribute(:activated,    true)
#    update_attribute(:activated_at, Time.zone.now)
#  end

  # Sends activation email.
#  def send_activation_email
#    UserMailer.account_activation(self).deliver
#  end

  # Sends activation email.
#  def send_fb_activation_email
#    UserMailer.fb_account_activation(self).deliver
#  end

  # Sets the password reset attributes.
#  def create_reset_digest
#    self.reset_token = User.new_token
#    update_attribute(:reset_digest,  User.digest(reset_token))
#    update_attribute(:reset_sent_at, Time.zone.now)
#  end

  # Sends password reset email.
#  def send_password_reset_email
#    UserMailer.password_reset(self).deliver
#  end

  # Returns true if a password reset has expired.
#  def password_reset_expired?
#    reset_sent_at < 2.hours.ago
#  end


  private
    def downcase_email
      self.email = email.downcase
    end

    #def create_activation_digest
    #  self.activation_token = User.new_token
    #  self.activation_digest = User.digest(activation_token)
    #end

    # Create a user using omniauth
    #def self.create_with_omniauth(auth)
    #  create! do |user|
    #    user.provider     = auth["provider"]
    #    user.uid          = auth["uid"]
    #    user.name         = auth["info"]["name"]
    #    user.email        = auth["info"]["email"]
    #    #user.password     = 'alphabetagamma' # TODO: ugly ass hack since we need a password to pass validation
    #    user.password_digest = '0' # TODO: ugly ass hack since we need a password to pass validation
    #    user.activated    = true
    #    user.activated_at = Time.now.to_s(:db)
    #  end
    #end

end
