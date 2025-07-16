class CreateQuestionnaires < ActiveRecord::Migration[8.0]
  def change
    create_table :questionnaires, id: :string do |t|
      t.string :title, null: false
      t.timestamps
    end
  end
end
