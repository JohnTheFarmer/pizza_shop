class CreateToppings < ActiveRecord::Migration[8.0]
  def change
    create_table :toppings do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
    add_index :toppings, :name, unique: true
  end
end
