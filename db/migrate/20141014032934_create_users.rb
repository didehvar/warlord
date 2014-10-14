class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username, length: 20
      t.index :username, unique: true

      t.timestamps
    end
  end
end
