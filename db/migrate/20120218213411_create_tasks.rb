class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.datetime :expiration
      t.boolean :reminder
      t.boolean :important
      t.boolean :complete
      t.text :note
      t.integer :context_id

      t.timestamps
    end
  end
end
