class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :team_id
      t.string :user_reference
      t.string :channel
      t.text :event_text
      t.string :type_label
      t.string :subtype_label
      t.timestamps null: false
    end
  end
end
