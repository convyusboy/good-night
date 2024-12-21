class CreateSleeps < ActiveRecord::Migration[7.2]
  def change
    create_table :sleeps do |t|
      t.datetime :ended_at
      t.belongs_to :user, null: false, foreign_key: true
      t.integer :duration

      t.timestamps
    end
  end
end
