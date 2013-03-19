class CreateCustomersAndProjectsAndProducts < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.boolean :active,      :default => true
      t.string  :email
      t.string  :name
      t.timestamps
    end
    add_index :customers, :email, :unique => true

    create_table :projects do |t|
      t.integer :customer_id
      t.string  :name
      t.integer :status_id
      t.timestamps
    end
    add_index :projects, :customer_id
    add_index :projects, :status_id

    create_table :project_logs do |t|
      t.string  :action
      t.text    :params
      t.integer :project_id
      t.integer :line_item_id
      t.integer :status_change
      t.timestamps
    end
    add_index :project_logs, :project_id

    create_table :products do |t|
      t.boolean :active,      :default => true
      t.string  :key
      t.string  :name
      t.decimal :price,       :precision => 9, :scale => 2
      t.string  :unit_id
      t.timestamps
    end
    add_index :products, :key, :unique => true

    create_table :line_items do |t|
      t.integer :modifier,    :default => 0
      t.integer :product_id
      t.integer :project_id
      t.decimal :quantity,   :precision => 10, :scale => 3
    end
    add_index :line_items, :product_id
    add_index :line_items, :project_id

    create_table :statuses do |t|
      t.string  :key
      t.string  :name
      t.integer :sorting
    end
    add_index :statuses, :key, :unique => true

    create_table :units do |t|
      t.boolean :active,      :default => true
      t.boolean :float,       :default => true
      t.string  :key
      t.string  :name
      t.string  :plural
    end
    add_index :units, :key, :unique => true

  end
end
