class CreateQuestions < ActiveRecord::Migration[8.0]
  def change
    create_table :questions, id: :string do |t|
      t.string :questionnaire_id, null: false
      t.string :label,                null: false
      t.integer :question_type,       null: false
      t.jsonb   :config,              default: {}
      t.jsonb   :visibility_condition,default: {}
      t.integer :position

      t.timestamps
    end

    add_foreign_key :questions, :questionnaires, column: :questionnaire_id
    add_index       :questions, [:questionnaire_id, :position]
  end
end
