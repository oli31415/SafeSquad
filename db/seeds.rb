MedicalInfo.delete_all
Responder.delete_all
Incident.delete_all
User.delete_all # should also delete all responders and Incidents
puts "Cleared the data base"

infos = MedicalInfo.list
infos.first.each_with_index do |_info, index|
  MedicalInfo.create!(title: infos.first[index], description: infos.last[index])
end
puts "Medical infos have been generated."

john = User.create!(
  email: 'john@example.com',
  password: 'password',
  first_name: 'John',
  last_name: 'Doe'
)
puts "John has been generated."

jane = User.create!(
  email: 'jane@example.com',
  password: 'password',
  first_name: 'Jane',
  last_name: 'Smith'
)
puts "Jane has been generated."

users = [john, jane]

(5..10).to_a.sample.times do
  i = Incident.new(
    is_closed: true,
    incident_type: Incident.types.sample
  )
  users = users.shuffle
  i.user = users.first
  i.save!

  r = Responder.new(
    has_accepted: true,
    has_arrived: true
  )
  r.user = users.last
  r.incident = i
  r.save!
end

# # Sasha's attempt at the responder + incident seeds
# Incident.create!(
#   user_id: 1,
#   location: 'Location 1',
#   is_closed: false
# )

# Incident.create!(
#   user_id: 2,
#   location: 'Location 2',
#   is_closed: true
# )

# # responders.rb
# Responder.create!(
#   incident_id: 1,
#   user_id: 1,
#   location: 'Location 1',
#   has_accepted: true
# )

# Responder.create!(
#   incident_id: 2,
#   user_id: 2,
#   location: 'Location 2',
#   has_accepted: false
# )
