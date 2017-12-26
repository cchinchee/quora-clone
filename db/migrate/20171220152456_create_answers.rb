class CreateAnswers < ActiveRecord::Migration[5.0]
	def change
		create_table :answers do |t|
			t.text	:description
			t.references :user, foreign_key:true, index: true
			t.references :question, index: true, foreign_key:true
			t.timestamps null: false
		end 
	end
end

