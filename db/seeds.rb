# encoding: utf-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require "csv"

CSV.foreach('db/31seeds.csv') do |row|
  User.create(:name   => row[1], 
              :family => row[2], 
              :given  => row[3], 
              :maiden => row[4], 
              :pobox  => row[5], 
              :region => row[6], 
              :city   => row[7], 
              :street => row[8], 
              :tel    => row[9], 
              :mobile => row[10], 
              :notes  => row[11], 
              :email  => row[12], 
              :password => row[13], 
              :password_confirmation => row[13], 
              :admin => true)
end

