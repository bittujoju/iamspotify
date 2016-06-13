class AddUserTable < ActiveRecord::Migration
  def change
  	create_table :users do |t|
      t.string   :name
      t.string   :data

      t.timestamps
    end
  end
end
