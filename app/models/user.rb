require 'bcrypt'

class User < ActiveRecord::Base
	# This is Sinatra! Remember to create a migration!
	include BCrypt
	has_secure_password
	has_many :questions
	has_many :answers
	validates :email, format: {with: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i}
	validates :email, :uniqueness => true
	validates :password, :length => {:minimum => 6 }
end
