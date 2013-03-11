# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Item i = Item.create(details_type: 'venue', img_url:
'http://upload.wikimedia.org/wikipedia/en/thumb/e/e9/Ruby_on_Rails.svg/150px-Ruby_on_Rails.svg.png',
minutes: 30, name: "Amadou's House")

Venue v = Venue.create(address: '999 Lindsey Manor Lane Silver Spring MD 20905',
latitude: 109.89, longitude: -29.434, item_id: i.id)

Item i2 = Item.create(details_type: 'link',
img_url:'http://rack.3.mshcdn.com/media/ZgkyMDEyLzEyLzA0LzIyL2hhcHB5MTR0aGJpLmIxOC5qcGcKcAl0aHVtYgk5NTB4NTM0IwplCWpwZw/90527e17/049/happy-14th-birthday-google-and-thanks-for-all-the-doodles-15544abfe8.jpg',
minutes: 45, name: 'Googley')

Link l = Link.create(link_type: 'Video',
url:'http://vimeo.com/channels/staffpicks/60043114', item_id: i2.id) 
