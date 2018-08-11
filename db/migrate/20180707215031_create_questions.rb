class CreateQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :questions, :id => :bigint do |table|
      table.text(:body, :null => false)
      table.text(:kind, :null => false)
      table.text(:moderation_state, :null => false)
      table.timestamps

      table.index(:moderation_state)
    end
  end
end
