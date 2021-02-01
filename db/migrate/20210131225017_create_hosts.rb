class CreateHosts < ActiveRecord::Migration[6.1]
  def change
    create_table :hosts do |t|
      t.string :name
      
      t.timestamps
    end

    add_index :hosts, :name, unique: true
  end
end
