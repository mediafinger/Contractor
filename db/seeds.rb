if Rails.env == "development"
  puts "Cleaning DB first ..."
  Customer.destroy_all
  Product.destroy_all
  Project.destroy_all
  LineItem.destroy_all
end

puts "Creating Customers ..."
Customer.create(:name => '--')
Customer.create(:name => 'Glossar Group', :email => "glossar@example.com")

puts "Creating Products ..."
Product.create(:key => "base",        :unit => :project,  :price => "1490", :active => true, :name => "Grundpreis")
Product.create(:key => "trans_de_it", :unit => :unit,     :price => "14.9", :active => true, :name => "Übersetzung deutsch - italienisch")
Product.create(:key => "trans_en_it", :unit => :unit,     :price => "13.9", :active => true, :name => "Übersetzung englisch - italienisch")
Product.create(:key => "proof_it",    :unit => :unit,     :price => "3.7",  :active => true, :name => "Korrekturlesen - italienisch")
Product.create(:key => "layout_word", :unit => :unit,     :price => "2.5",  :active => true, :name => "Layout - Word")
Product.create(:key => "zz_minus_10", :unit => :sum,      :price => "0.9",  :active => true, :name => "Rabatt - 10%")
Product.create(:key => "zz_plus_25",  :unit => :sum,      :price => "1.25", :active => true, :name => "Zuschlag - Zeit")
Product.create(:key => "zz_plus_15",  :unit => :sum,      :price => "1.15", :active => true, :name => "Zuschlag - Komplexität")

puts "Creating Projects ..."
p1 = Project.create(:customer_id => Customer.last.id, :name => "Primärprojekt",   :status => "in Vorbereitung")
p2 = Project.create(:customer_id => Customer.last.id, :name => "Sekundärprojekt", :status => "läuft")
p3 = Project.create(:customer_id => Customer.last.id, :name => "Rabattprojekt",   :status => "beendet")
p4 = Project.create(:customer_id => Customer.last.id, :name => "Komplexprojekt",  :status => "KVA")

puts "Creating LineItems ..."
LineItem.create(:project_id => p1.id, :product_id => Product.find_by_key(:base),          :units => 1)
LineItem.create(:project_id => p1.id, :product_id => Product.find_by_key(:trans_de_it),   :units => 1000)
LineItem.create(:project_id => p2.id, :product_id => Product.find_by_key(:base),          :units => 1)
LineItem.create(:project_id => p2.id, :product_id => Product.find_by_key(:trans_en_it),   :units => 500)
LineItem.create(:project_id => p3.id, :product_id => Product.find_by_key(:base),          :units => 1)
LineItem.create(:project_id => p3.id, :product_id => Product.find_by_key(:proof_it),      :units => 500)
LineItem.create(:project_id => p3.id, :product_id => Product.find_by_key(:zz_minus_10),   :units => -10)
LineItem.create(:project_id => p4.id, :product_id => Product.find_by_key(:base),          :units => 500)
LineItem.create(:project_id => p4.id, :product_id => Product.find_by_key(:proof_it),      :units => 1)
LineItem.create(:project_id => p4.id, :product_id => Product.find_by_key(:zz_plus_15),    :units => 15)
