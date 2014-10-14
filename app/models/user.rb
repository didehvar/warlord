class User < ActiveRecord::Base
  validates :username, presence: true, uniqueness: true, length: { in: 3..20 }
end
