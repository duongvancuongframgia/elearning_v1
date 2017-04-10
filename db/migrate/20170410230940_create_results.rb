class CreateResults < ActiveRecord::Migration[5.0]
  def change
    create_table :results do |t|
      t.references :exam, foreign_key: true
      t.references :question, foreign_key: true
      t.references :answer, foreign_key: true
      t.timestamps
    end
  end
end
