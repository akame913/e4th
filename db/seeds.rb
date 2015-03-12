# encoding: utf-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require "csv"

CSV.foreach('db/seed.csv') do |row|
  User.create(:name   => row[4], 
              :family => row[5], 
              :given  => row[6], 
              :maiden => row[7], 
              :pobox  => row[8], 
              :region => row[9], 
              :city   => row[10], 
              :street => row[11], 
              :tel    => row[12], 
              :mobile => row[13], 
              :notes  => row[14], 
              :email  => row[15], 
              :password => row[16], 
              :password_confirmation => row[16], 
              :admin => row[17],
              :group_id => row[18])
end

