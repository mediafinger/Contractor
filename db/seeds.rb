if Rails.env == "development"
  puts "Cleaning DB first ..."
  Address.destroy_all
  Customer.destroy_all
  Invoice.destroy_all
  LineItem.destroy_all
  Product.destroy_all
  Project.destroy_all
  Status.destroy_all
  Unit.destroy_all
  User.destroy_all
end


puts "Creating Users ..."
User.create!(:name => 'Andy',  :email => "andy@mediafinger.com",    :birthday => "19770605", :active => false, :active => true, :admin => true)
User.create!(:name => 'Micky', :email => "michela.donda@gmail.com", :birthday => "19790926", :active => false, :active => false)


puts "Creating Customers ..."
Customer.create!(:name => '--',            :email => "none@example.com")
Customer.create!(:name => 'Film & TV',     :email => "film@example.com")
Customer.create!(:name => 'Glossa Group',  :email => "glossa@example.com")


# puts "Creating Addresses ..."
# Address.create!(:city => "Barcelona", :owner_type => "User",     :owner => User.find_by(email: "andy@mediafinger.com"),    :mobile => "+34688988550")
# Address.create!(:city => "Barcelona", :owner_type => "User",     :owner => User.find_by(email: "michela.donda@gmail.com"), :company_name => "DondaLations")
# Address.create!(:city => "Hamburg",   :owner_type => "Customer", :owner => Customer.find_by(email: "glossa@example.com"),  :company_name => "Glossar Group Worldwide GmbH")
# Address.create!(:city => "Barcelona", :owner_type => "Customer", :owner => Customer.find_by(email: "film@example.com"),    :company_name => "Film & TV Schnitt und Vertonungs AG")


puts "Creating Units ..."
Unit.create!(:key => :euro,      :name => "Euro",    :plural => "Euro")
Unit.create!(:key => :hour,      :name => "Stunde",  :plural => "Stunden")
Unit.create!(:key => :word,      :name => "Wort",    :plural => "Wörter",   :float => false)
Unit.create!(:key => :project,   :name => "Projekt", :plural => "Projekte", :float => false)


puts "Creating Products ..."
Product.create!(:key => :setup_fee,   :unit => Unit.find_by(key: :project),  :price => "1490", :name => "Grundpreis")
Product.create!(:key => :trans_de_it, :unit => Unit.find_by(key: :word),     :price => "12.0", :name => "Übersetzung deutsch - italienisch")
Product.create!(:key => :trans_en_it, :unit => Unit.find_by(key: :word),     :price => "12.0", :name => "Übersetzung englisch - italienisch")
Product.create!(:key => :proof_it,    :unit => Unit.find_by(key: :word),     :price => "4.5",  :name => "Korrekturlesen - italienisch")
Product.create!(:key => :layout_word, :unit => Unit.find_by(key: :word),     :price => "2.5",  :name => "Layout - Word")
Product.create!(:key => :consulting,  :unit => Unit.find_by(key: :hour),     :price => "6500", :name => "Persönliche Beratung")
Product.create!(:key => :voucher,     :unit => Unit.find_by(key: :euro),     :price => "100",  :name => "Gutschrift")


puts "Creating Statuses ..."
Status.create!(:key => :opportunity,  :name => "in Vorbereitung",            :sorting => 1)
Status.create!(:key => :offer,        :name => "Angebot gestellt",           :sorting => 2)
Status.create!(:key => :in_progress,  :name => "in Bearbeitung",             :sorting => 3)
Status.create!(:key => :done,         :name => "fertig",                     :sorting => 4)
Status.create!(:key => :finalization, :name => "Abrechnung",                 :sorting => 5)
Status.create!(:key => :successful,   :name => "Erfolgreich abgeschlossen",  :sorting => 6)
Status.create!(:key => :canceled,     :name => "abgebrochen",                :sorting => 7)


puts "Creating Projects ..."
p1 = Project.create!(:customer => Customer.find_by(email: "none@example.com"),    :name => "Wunschkonzert",        :status => Status.find_by(key: :opportunity))
p2 = Project.create!(:customer => Customer.find_by(email: "glossa@example.com"),  :name => "Linsen - neuer Kunde", :status => Status.find_by(key: :offer))
p3 = Project.create!(:customer => Customer.find_by(email: "film@example.com"),    :name => "Erstauftrag",          :status => Status.find_by(key: :in_progress))
p4 = Project.create!(:customer => Customer.find_by(email: "glossa@example.com"),  :name => "Kleinkram",            :status => Status.find_by(key: :done))
p5 = Project.create!(:customer => Customer.find_by(email: "glossa@example.com"),  :name => "Eppendorf - Februar",  :status => Status.find_by(key: :finalization))
p6 = Project.create!(:customer => Customer.find_by(email: "glossa@example.com"),  :name => "Eppendorf - Januar",   :status => Status.find_by(key: :successful),  :paid => 1.month.ago)
p7 = Project.create!(:customer => Customer.find_by(email: "none@example.com"),    :name => "abgelehnt",            :status => Status.find_by(key: :canceled))


puts "Creating LineItems ..."
LineItem.create!(:project => p1, :product => Product.find_by(key: :trans_de_it),  :quantity => 3000,    :modifier => 25)
LineItem.create!(:project => p1, :product => Product.find_by(key: :trans_de_it),  :quantity => 2200,    :modifier => 25)

LineItem.create!(:project => p2, :product => Product.find_by(key: :trans_de_it),  :quantity => 2400,    :modifier => -29)

LineItem.create!(:project => p3, :product => Product.find_by(key: :trans_en_it),  :quantity => 8200)
LineItem.create!(:project => p3, :product => Product.find_by(key: :consulting),   :quantity => 4)
LineItem.create!(:project => p3, :product => Product.find_by(key: :voucher),      :quantity => 25)

LineItem.create!(:project => p4, :product => Product.find_by(key: :trans_de_it),  :quantity => 600,     :modifier => -29)
LineItem.create!(:project => p4, :product => Product.find_by(key: :trans_de_it),  :quantity => 1700,    :modifier => -29)
LineItem.create!(:project => p4, :product => Product.find_by(key: :trans_en_it),  :quantity => 85,      :modifier => -29)
LineItem.create!(:project => p4, :product => Product.find_by(key: :proof_it),     :quantity => 500,     :modifier => -29)

LineItem.create!(:project => p5, :product => Product.find_by(key: :trans_en_it),  :quantity => 4000,    :modifier => -25)
LineItem.create!(:project => p5, :product => Product.find_by(key: :layout_word),  :quantity => 4000,    :modifier => 20)

LineItem.create!(:project => p6, :product => Product.find_by(key: :trans_de_it),  :quantity => 2450,    :modifier => -25)

LineItem.create!(:project => p7, :product => Product.find_by(key: :setup_fee),    :quantity => 1)
LineItem.create!(:project => p7, :product => Product.find_by(key: :trans_de_it),  :quantity => 890,     :modifier => 25)
LineItem.create!(:project => p7, :product => Product.find_by(key: :trans_de_it),  :quantity => 2200,    :modifier => 25)


puts "Creating Invoices ..."
Invoice.create!(:sent => 1.week.ago, :project => p1, :kind => :offer,   :until => 1.day.ago,       :user => User.find_by(email: "michela.donda@gmail.com"))
Invoice.create!(:sent => 1.week.ago, :project => p5, :kind => :quote,   :until => 4.days.ago,      :user => User.find_by(email: "michela.donda@gmail.com"))
Invoice.create!(:sent => 1.day.ago,  :project => p5, :kind => :invoice, :until => 1.week.from_now, :user => User.find_by(email: "michela.donda@gmail.com")) 
