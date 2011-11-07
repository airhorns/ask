class CreateAnswerMetaData < ActiveRecord::Migration
  def change
    create_table :answer_meta_data do |t|
      t.references :answer
      t.string :key
      t.string :value

      t.timestamps
    end
  end
end
