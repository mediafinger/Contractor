class CreateCustomersAndProjectsAndProductsAndUsers < ActiveRecord::Migration
  def change
    create_table :addresses, :force => true do |t|
      t.string   :bank_account_number
      t.string   :bank_name
      t.string   :bank_number
      t.string   :city
      t.string   :company_name
      t.string   :country
      t.text     :description
      t.string   :email
      t.string   :fax
      t.string   :fon
      t.string   :foto
      t.string   :language
      t.string   :mobile
      t.string   :name
      t.integer  :owner_id
      t.string   :owner_type
      t.string   :region
      t.string   :street
      t.string   :tax_permill
      t.string   :tax_number
      t.string   :website
      t.string   :zip
      t.timestamps
    end
    add_index :addresses, :owner_id
    add_index :addresses, :owner_type

    create_table :customers do |t|
      t.boolean :active,      :default => true
      t.date    :birthday
      t.string  :email
      t.string  :name
      t.timestamps
    end
    add_index :customers, :email, :unique => true

    create_table :invoices do |t|
      t.boolean :accepted,      :default => false
      t.string  :kind
      t.boolean :open,          :default => true
      t.integer :project_id
      t.date    :sent
      t.date    :until
      t.integer :user_id
      t.timestamps
    end
    add_index :invoices, :project_id
    add_index :invoices, :kind
    add_index :invoices, :until
    add_index :invoices, :user_id

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

    create_table :users do |t|
      t.boolean :active,      :default => true
      t.boolean :admin,       :default => false        
      t.date    :birthday
      t.string  :email
      t.string  :name

      t.string   :authentication_token    # devise Token authenticatable
      t.datetime :remember_created_at     # devise Rememberable
      
      t.timestamps
    end
    add_index :users, :email, :unique => true
    add_index :users, :authentication_token, :unique => true

  end
end
