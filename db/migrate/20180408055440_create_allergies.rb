class CreateAllergies < ActiveRecord::Migration[5.1]
  def change
    create_table :allergies, :id => :uuid do |table|
      table.text(:name, :null => false)
      table.text(:moderation_state, :null => false)
      table.timestamps

      table.index(:moderation_state)
      table.index(:name, :unique => true)
    end
  end
end
