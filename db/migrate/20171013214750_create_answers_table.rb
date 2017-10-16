class CreateAnswersTable < ActiveRecord::Migration[5.1]
  def change
    create_table :answers do |t|
      t.string :answers
      t.integer :user_id
      t.integer :question_id
    end
  end
end
