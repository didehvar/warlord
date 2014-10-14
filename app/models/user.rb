class User < ActiveRecord::Base
  before_save :downcase_username_email

  validates :username, presence: true, uniqueness: { case_sensitive: false },
            format: { with: /\A[\w+]+\z/i }, length: { in: 3..20 }
  validates :email, presence: true, uniqueness: { case_sensitive: false },
            format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i }

  has_secure_password
  validates :password, length: { minimum: 8 }

  def downcase_username_email
    self.username.downcase!
    self.email.downcase!
  end
end
