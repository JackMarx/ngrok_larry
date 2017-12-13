class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :team_id
      t.string :user_access_token
      t.string :bot_user_id
      t.string :bot_access_token
      t.timestamps null: false
    end
  end
end
