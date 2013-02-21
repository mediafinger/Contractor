class CreateCustomersAndProjectsAndProducts < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :name
      t.string :email
      t.boolean :active

      t.timestamps
    end

    create_table :projects do |t|
      t.integer :customer_id
      t.string :title
      t.string :status
      t.integer :units

      t.timestamps
    end

    create_table :products do |t|
      t.string :description
      t.string :key
      t.string :unit
      t.float :price

      t.timestamps
    end

    create_table :products_projects do |t|
      t.integer :product_id
      t.integer :project_id
    end
  end
end
