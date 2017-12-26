class Vote < ActiveRecord::Base
	# This is Sinatra! Remember to create a migration!
	validates :user_id, uniqueness: {scope: :answer_id}
	belongs_to :user
	belongs_to :answer
end
