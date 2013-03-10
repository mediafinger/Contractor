class CreateCustomersAndProjectsAndProducts < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.boolean :active,      :default => true
      t.string  :email
      t.string  :name
      t.timestamps
    end

    create_table :projects do |t|
      t.integer :customer_id
      t.string  :name
      t.integer :status_id
      t.timestamps
    end

    create_table :products do |t|
      t.boolean :active,      :default => true
      t.string  :key
      t.string  :name
      t.decimal :price,       :precision => 9, :scale => 2
      t.string  :unit_id
      t.timestamps
    end

    create_table :line_items do |t|
      t.integer :modifier,    :default => 0
      t.integer :project_id
      t.string  :product_id
      t.decimal :quantity,   :precision => 10, :scale => 3
    end

    create_table :statuses do |t|
      t.string  :key
      t.string  :name
      t.integer :sorting
    end

    create_table :units do |t|
      t.boolean :active,      :default => true
      t.boolean :float,       :default => true
      t.string  :key
      t.string  :name
      t.string  :plural
    end
  end
end
