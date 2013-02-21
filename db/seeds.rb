# encoding: UTF-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

if Rails.env == "development"
  puts "Cleaning DB first ..."
  Customer.destroy_all
  Product.destroy_all
  Project.destroy_all
end

Customer.create(:name => '--')
Customer.create(:name => 'Glossar Group', :email => "glossar@example.com")

Product.create(:description => "Grundpreis", :key => "base", :unit => :project, :price => "1490")
Product.create(:description => "Übersetzung deutsch - italienisch", :key => "trans_de_it", :unit => :unit, :price => "14.9")
Product.create(:description => "Übersetzung englisch - italienisch", :key => "trans_en_it", :unit => :unit, :price => "13.9")
Product.create(:description => "Korrekturlesen - italienisch", :key => "proof_it", :unit => :unit, :price => "3.7")
Product.create(:description => "Layout - Word", :key => "layout_word", :unit => :unit, :price => "2.5")
Product.create(:description => "Rabatt - 10%", :key => "zz_minus_10", :unit => :sum, :price => "0.9")
Product.create(:description => "Zuschlag - Zeit", :key => "zz_plus_25", :unit => :sum, :price => "1.25")
Product.create(:description => "Zuschlag - Komplexität", :key => "zz_plus_15", :unit => :sum, :price => "1.15")

p = Project.new(:customer_id => Customer.last.id, :title => "Primärprojekt", :units => 1000, :status => "in Vorbereitung")
p.products = [Product.find_by_key(:trans_de_it), Product.find_by_key(:base)]
p.save
p = Project.new(:customer_id => Customer.last.id, :title => "Sekundärprojekt", :units => 500, :status => "läuft")
p.products = [Product.find_by_key(:trans_en_it), Product.find_by_key(:base)]
p.save
p = Project.new(:customer_id => Customer.last.id, :title => "Rabattprojekt", :units => 500, :status => "beendet")
p.products = [Product.find_by_key(:proof_it), Product.find_by_key(:base), Product.find_by_key(:zz_minus_10)]
p.save
p = Project.new(:customer_id => Customer.last.id, :title => "Komplexprojekt", :units => 500, :status => "KVA")
p.products = [Product.find_by_key(:proof_it), Product.find_by_key(:base), Product.find_by_key(:zz_plus_15)]
p.save
