User.all.each do |u|
  u.medical_info_id = nil
  u.save!
end
puts "MedicalInfo reset"

MedicalInfo.delete_all

infos = MedicalInfo.list
infos.first.each_with_index do |_info, index|
  MedicalInfo.create!(title: infos.first[index], description: infos.last[index])
end
puts "Medical infos have been generated."

puts "Demo? (y/n)"
answer = gets.chomp
if ["yes", "y", "yea"].include?(answer.downcase)
  s = User.find_by(first_name: "Sasha")
  s.languages = ""
  s.medication = ""
  s.height = ""
  s.medical_info_id = MedicalInfo.first.id # TODO
  s.save!

  puts "Sasha has been reset"

  num = 0

  o = User.find_by(first_name: "Oliver")
  incidents = s.incidents.select do |i|
    r = i.responders.find { |r| r.has_accepted }
    if r.nil?
      false
    else
      r.user == o
    end
  end
  incidents.each { |i| i.destroy }
  num += incidents.length

  incidents = o.incidents.select do |i|
    r = i.responders.find { |r| r.has_accepted }
    if r.nil?
      false
    else
      r.user == s
    end
  end
  incidents.each { |i| i.destroy }
  num += incidents.length

  puts "#{num} Incidents relating to Sasha and Oliver have been deleted"

else
  Responder.delete_all
  Incident.delete_all
  User.delete_all # should also delete all responders and Incidents
  puts "Cleared the data base"


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

  oliver = User.create!(
    email: 'oliver@example.com',
    password: 'password',
    first_name: 'Oliver',
    last_name: 'Stofer'
  )
  puts "Oliver has been generated."

  sasha = User.create!(
    email: 'sasha@example.com',
    password: 'password',
    first_name: 'Sasha',
    last_name: 'Scherrer'
  )
  puts "Sasha has been generated."

  gioia = User.create!(
    email: 'gioia@example.com',
    password: 'password',
    first_name: 'Gioia',
    last_name: 'Hauri'
  )
  puts "Gioia has been generated."

  users = [john, jane, oliver, sasha, gioia]

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
end
