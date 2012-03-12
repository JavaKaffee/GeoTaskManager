class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.integer :interval
      t.string :layout

      t.timestamps
    end
  end
end
