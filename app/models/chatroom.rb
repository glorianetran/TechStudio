class Chatroom < ApplicationRecord
    has_many :chatroom_users
    has_many :isers, through: :chatroom_users
    has_many :messages
end
