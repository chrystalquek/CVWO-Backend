class User < ApplicationRecord
    # bcrypt handles passwords
    has_secure_password

    # username and email must be present and unique
    validates :username, presence: true
    validates :username, uniqueness: true
    # minimum password length can be changed
    validates :password, length: { minimum: 4 }, on: :create
    validates :email, presence: true
    validates :email, uniqueness: true
    validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

    # upon deletion of user, all user's todos are also destroyed
    has_many :todos, dependent: :destroy
end
