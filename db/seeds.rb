if Rails.env == "development"
  puts "Cleaning DB first ..."
  Customer.destroy_all
  Product.destroy_all
  Project.destroy_all
  LineItem.destroy_all
end

puts "Creating Customers ..."
Customer.create(:name => '--')
Customer.create(:name => 'Film & TV',     :email => "film@example.com")
Customer.create(:name => 'Glossar Group', :email => "glossar@example.com")

puts "Creating Products ..."
Product.create(:key => "base",        :unit => :project,  :price => "1490", :active => true, :name => "Grundpreis")
Product.create(:key => "trans_de_it", :unit => :unit,     :price => "12.0", :active => true, :name => "Übersetzung deutsch - italienisch")
Product.create(:key => "trans_en_it", :unit => :unit,     :price => "12.0", :active => true, :name => "Übersetzung englisch - italienisch")
Product.create(:key => "proof_it",    :unit => :unit,     :price => "4.5",  :active => true, :name => "Korrekturlesen - italienisch")
Product.create(:key => "layout_word", :unit => :unit,     :price => "2.5",  :active => true, :name => "Layout - Word")
Product.create(:key => "consulting",  :unit => :hour,     :price => "6500", :active => true, :name => "Persönliche Beratung")
Product.create(:key => "voucher",     :unit => :euro,     :price => "100",  :active => true, :name => "Gutschrift")

puts "Creating Projects ..."
p1 = Project.create(:customer => Customer.find_by_email("glossar@example.com"), :name => "Eppendorf - Februar",  :status => "beendet")
p2 = Project.create(:customer => Customer.find_by_email("glossar@example.com"), :name => "Linsen - neuer Kunde", :status => "Rechnung geschrieben")
p3 = Project.create(:customer => Customer.find_by_email("glossar@example.com"), :name => "Kleinkram",            :status => "läuft")
p4 = Project.create(:customer => Customer.find_by_email("film@example.com"),    :name => "Erstauftrag",          :status => "in Vorbereitung")
p5 = Project.create(:customer => Customer.find_by_name("--"),                   :name => "Wunschkonzert",        :status => "kommt noch")

puts "Creating LineItems ..."
LineItem.create(:project_id => p1.id, :product_id => Product.find_by_key(:trans_de_it),   :units => 3000,    :modifier => -25)
LineItem.create(:project_id => p1.id, :product_id => Product.find_by_key(:trans_de_it),   :units => 2200,    :modifier => -25)

LineItem.create(:project_id => p2.id, :product_id => Product.find_by_key(:trans_de_it),   :units => 2400,    :modifier => -29)

LineItem.create(:project_id => p3.id, :product_id => Product.find_by_key(:trans_de_it),   :units => 600,    :modifier => -29)
LineItem.create(:project_id => p3.id, :product_id => Product.find_by_key(:trans_de_it),   :units => 1700,   :modifier => -29)
LineItem.create(:project_id => p3.id, :product_id => Product.find_by_key(:trans_en_it),   :units => 85,     :modifier => -29)
LineItem.create(:project_id => p3.id, :product_id => Product.find_by_key(:proof_it),      :units => 500,    :modifier => -29)

LineItem.create(:project_id => p4.id, :product_id => Product.find_by_key(:trans_en_it),   :units => 8200)
LineItem.create(:project_id => p4.id, :product_id => Product.find_by_key(:consulting),    :units => 4)
LineItem.create(:project_id => p4.id, :product_id => Product.find_by_key(:voucher),       :units => 25)

LineItem.create(:project_id => p5.id, :product_id => Product.find_by_key(:base),          :units => 1)
LineItem.create(:project_id => p5.id, :product_id => Product.find_by_key(:trans_en_it),   :units => 4000)
LineItem.create(:project_id => p5.id, :product_id => Product.find_by_key(:layout_word),   :units => 4000,    :modifier => 20)

