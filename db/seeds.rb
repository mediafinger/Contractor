if Rails.env == "development"
  puts "Cleaning DB first ..."
  Address.destroy_all
  Customer.destroy_all
  LineItem.destroy_all
  Product.destroy_all
  Project.destroy_all
  Status.destroy_all
  Unit.destroy_all
  User.destroy_all
end

puts "Creating Users ..."
User.create(:name => 'Andy',  :email => "andy@mediafinger.com",     :birthday => "19770605")
User.create(:name => 'Micky', :email => "michela.donda@gmail.com",  :birthday => "19790926")

puts "Creating Customers ..."
Customer.create(:name => '--',            :email => "none@example.com")
Customer.create(:name => 'Film & TV',     :email => "film@example.com")
Customer.create(:name => 'Glossar Group', :email => "glossar@example.com")

puts "Creating Addresses ..."
Address.create(:city => "Barcelona", :owner_type => "User", :owner_id => User.find_by_email("andy@mediafinger.com").id, :mobile => "+34688988550")
Address.create(:city => "Barcelona", :owner_type => "User", :owner_id => User.find_by_email("michela.donda@gmail.com").id, :company_name => "DondaLations")
Address.create(:city => "Hamburg",   :owner_type => "Customer", :owner_id => Customer.find_by_email("glossar@example.com").id, :company_name => "Glossar Group Worldwide GmbH")
Address.create(:city => "Barcelona", :owner_type => "Customer", :owner_id => Customer.find_by_email("film@example.com").id, :company_name => "Film & TV Schnitt und Vertonungs AG")

puts "Creating Units ..."
Unit.create(:key => :euro,      :name => "Euro",    :plural => "Euro")
Unit.create(:key => :hour,      :name => "Stunde",  :plural => "Stunden")
Unit.create(:key => :word,      :name => "Wort",    :plural => "Wörter",   :float => false)
Unit.create(:key => :project,   :name => "Projekt", :plural => "Projekte", :float => false)

puts "Creating Products ..."
Product.create(:key => :setup_fee,   :unit => Unit.find_by_key(:project),  :price => "1490", :name => "Grundpreis")
Product.create(:key => :trans_de_it, :unit => Unit.find_by_key(:word),     :price => "12.0", :name => "Übersetzung deutsch - italienisch")
Product.create(:key => :trans_en_it, :unit => Unit.find_by_key(:word),     :price => "12.0", :name => "Übersetzung englisch - italienisch")
Product.create(:key => :proof_it,    :unit => Unit.find_by_key(:word),     :price => "4.5",  :name => "Korrekturlesen - italienisch")
Product.create(:key => :layout_word, :unit => Unit.find_by_key(:word),     :price => "2.5",  :name => "Layout - Word")
Product.create(:key => :consulting,  :unit => Unit.find_by_key(:hour),     :price => "6500", :name => "Persönliche Beratung")
Product.create(:key => :voucher,     :unit => Unit.find_by_key(:euro),     :price => "100",  :name => "Gutschrift")

puts "Creating Statuses ..."
Status.create(:key => :opportunity,         :name => "in Vorbereitung",                         :sorting => 1)
Status.create(:key => :offer,               :name => "Angebot gestellt (KVA)",                  :sorting => 2)
Status.create(:key => :in_progress,         :name => "in Bearbeitung",                          :sorting => 3)
Status.create(:key => :done,                :name => "fertig",                                  :sorting => 4)
Status.create(:key => :waiting_for_payment, :name => "Rechnung gestellt",                       :sorting => 5)
Status.create(:key => :successful,          :name => "Erfolgreich beendet / Zahlung erhalten",  :sorting => 6)
Status.create(:key => :canceled,            :name => "abgebrochen",                             :sorting => 7)


puts "Creating Projects ..."
p1 = Project.create(:customer => Customer.find_by_name("--"),                   :name => "Wunschkonzert",        :status => Status.find_by_key(:opportunity))
p2 = Project.create(:customer => Customer.find_by_email("glossar@example.com"), :name => "Linsen - neuer Kunde", :status => Status.find_by_key(:offer))
p3 = Project.create(:customer => Customer.find_by_email("film@example.com"),    :name => "Erstauftrag",          :status => Status.find_by_key(:in_progress))
p4 = Project.create(:customer => Customer.find_by_email("glossar@example.com"), :name => "Kleinkram",            :status => Status.find_by_key(:done))
p5 = Project.create(:customer => Customer.find_by_email("glossar@example.com"), :name => "Eppendorf - Februar",  :status => Status.find_by_key(:waiting_for_payment))
p6 = Project.create(:customer => Customer.find_by_email("glossar@example.com"), :name => "Eppendorf - Januar",   :status => Status.find_by_key(:successful))
p7 = Project.create(:customer => Customer.find_by_name("--"),                   :name => "abgelehnt",            :status => Status.find_by_key(:canceled))


puts "Creating LineItems ..."
LineItem.create(:project_id => p1.id, :product_id => Product.find_by_key(:trans_de_it).id,   :quantity => 3000,    :modifier => 25)
LineItem.create(:project_id => p1.id, :product_id => Product.find_by_key(:trans_de_it).id,   :quantity => 2200,    :modifier => 25)

LineItem.create(:project_id => p2.id, :product_id => Product.find_by_key(:trans_de_it).id,   :quantity => 2400,    :modifier => -29)

LineItem.create(:project_id => p3.id, :product_id => Product.find_by_key(:trans_en_it).id,   :quantity => 8200)
LineItem.create(:project_id => p3.id, :product_id => Product.find_by_key(:consulting).id,    :quantity => 4)
LineItem.create(:project_id => p3.id, :product_id => Product.find_by_key(:voucher).id,       :quantity => 25)

LineItem.create(:project_id => p4.id, :product_id => Product.find_by_key(:trans_de_it).id,   :quantity => 600,    :modifier => -29)
LineItem.create(:project_id => p4.id, :product_id => Product.find_by_key(:trans_de_it).id,   :quantity => 1700,   :modifier => -29)
LineItem.create(:project_id => p4.id, :product_id => Product.find_by_key(:trans_en_it).id,   :quantity => 85,     :modifier => -29)
LineItem.create(:project_id => p4.id, :product_id => Product.find_by_key(:proof_it).id,      :quantity => 500,    :modifier => -29)

LineItem.create(:project_id => p5.id, :product_id => Product.find_by_key(:trans_en_it).id,   :quantity => 4000,    :modifier => -25)
LineItem.create(:project_id => p5.id, :product_id => Product.find_by_key(:layout_word).id,   :quantity => 4000,    :modifier => 20)

LineItem.create(:project_id => p6.id, :product_id => Product.find_by_key(:trans_de_it).id,   :quantity => 2450,    :modifier => -25)

LineItem.create(:project_id => p7.id, :product_id => Product.find_by_key(:setup_fee).id,     :quantity => 1)
LineItem.create(:project_id => p7.id, :product_id => Product.find_by_key(:trans_de_it).id,   :quantity => 890,     :modifier => 25)
LineItem.create(:project_id => p7.id, :product_id => Product.find_by_key(:trans_de_it).id,   :quantity => 2200,    :modifier => 25)
