class CreateVotes < ActiveRecord::Migration[5.0]
	def change
		create_table :votes do |t|
			t.integer :count, default: 0
			t.references :user, foreign_key: true, index: true
			t.references :answer, foreign_key: true, index: true
			t.timestamps null: false
		end
	end
end
