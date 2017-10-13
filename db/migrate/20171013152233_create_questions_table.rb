class CreateQuestionsTable < ActiveRecord::Migration[5.1]
  def change
    create_table :questions do |t|
      t.string :question
      t.integer :user_id
    end
  end
end
