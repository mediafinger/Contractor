class CreateCustomersAndProjects < ActiveRecord::Migration
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
      t.string :target_language
      t.string :source_language

      t.timestamps
    end
  end
end
