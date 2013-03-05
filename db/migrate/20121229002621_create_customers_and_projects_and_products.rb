class CreateCustomersAndProjectsAndProducts < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string  :name
      t.string  :email
      t.boolean :active,      :default => true
      t.timestamps
    end

    create_table :projects do |t|
      t.integer :customer_id
      t.string  :name
      t.string  :status
      t.timestamps
    end

    create_table :products do |t|
      t.string  :name
      t.string  :key
      t.string  :unit
      t.decimal :price,       :precision => 9, :scale => 2
      t.boolean :active,      :default => true
      t.timestamps
    end

    create_table :line_items do |t|
      t.string  :product_id
      t.integer :project_id
      t.integer :modifier,    :default => 0
      t.decimal :units,       :precision => 10, :scale => 3
    end
  end
end
