class CreateCustomersAndProjects < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :name
      t.string :email
      t.boolean :active

      t.timestamps
    end

    create_table :projects do |t|
      t.string :title
      t.string :status
      t.string :target_language
      t.string :customer_id

      t.timestamps
    end
  end
end
