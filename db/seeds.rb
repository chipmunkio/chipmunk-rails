# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)

v = Venue.create(:address => "123 Tennyson Avenue, Palo Alto, CA 94301")
Item.create(:name => "Spencer's house", :minutes => 15, :details_type => "Venue", :details_id => v.id)

l = Link.create(:url => "http://netspencer.com")
Item.create(:name => "Spencer's website", :minutes => 10, :details_type => "Link", :details_id => l.id)