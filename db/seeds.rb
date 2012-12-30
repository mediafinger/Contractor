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

Product.create(:description => "Übersetzung deutsch - italienisch", :unit => "Wort", :price => "14.9")
Product.create(:description => "Übersetzung englisch - italienisch", :unit => "Wort", :price => "13.9")
Product.create(:description => "Korrekturlesen - italienisch", :unit => "Wort", :price => "3.7")

Project.create(:customer_id => Customer.last.id, :title => "Primärprojekt", :units => 1000, :product_id => Product.first.id,
                :status => "in Vorbereitung", :source_language => "deutsch", :target_language => "italienisch")
Project.create(:customer_id => Customer.last.id, :title => "Sekundärprojekt", :units => 500, :product_id => (Product.first.id + 1),
                :status => "läuft", :source_language => "englisch", :target_language => "italienisch")
