# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create(id: '1', first_name: 'Brendon', last_name: 'McDonnell', email: 'brendon@nwpro.org', city: 'Naples',
  state: 'Florida', zip: '34117', password: 'solo1', password_confirmation: 'solo1', admin: 'true', phone: '2395951706')
#Campaign.create(id: '1', user_id: User.first.id, name: 'A Test Campaign', diocese: 'Diocese of Venice', address: '1234 Main St',
#  city: 'Venice', state: 'FL', zip: '34333', contact_name: 'Fr Bob', phone: '813-777-7777', fax: '813-333-3333',
#  email: 'email@dov.com', url: 'dov.org', number_of_families: '300', contribution_income: '500.00',
#  has_pacesetter: 'true', standalone: 'false')