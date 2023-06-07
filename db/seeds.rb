# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
# users.rb
User.create!(
  email: 'john@example.com',
  password: 'password',
  first_name: 'John',
  last_name: 'Doe'
)

User.create!(
  email: 'jane@example.com',
  password: 'password',
  first_name: 'Jane',
  last_name: 'Smith'
)






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
