class User < ApplicationRecord
    has_secure_password
    has_one_attached :image
    validates :username, :email, :password, :password_confirmation, presence: true
    validates :username,:email, uniqueness: true
    validates :email, format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i ,message: ' Entered is invalid'}
    validates :password, length: {is: 8}
    validates :password, confirmation: true

    scope :find_by_user_name,->(username){where(username: username).take!}

end
