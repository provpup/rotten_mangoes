class User < ActiveRecord::Base
  has_many :review
  has_secure_password
end
