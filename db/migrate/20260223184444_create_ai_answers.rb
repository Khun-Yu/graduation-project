class CreateAiAnswers < ActiveRecord::Migration[8.1]
  def change
    create_table :ai_answers do |t|
      t.references :question, null: false, foreign_key: true, index: { unique: true }
      t.text :content, null: false

      t.timestamps
    end
  end
end
