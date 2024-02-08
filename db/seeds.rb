# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

cities = ["Paris", "Lyon", "Marseille", "Toulouse", "Nice"]
cities.each do |name|
  City.create!(name: name)
end

# Créer des spécialités
specialties = ["Cardiologie", "Dermatologie", "Pédiatrie", "Neurologie"]
specialties.each do |name|
  Specialty.create!(name: name)
end

# Créer des docteurs
10.times do
  Doctor.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    zip_code: Faker::Address.zip_code,
    city: City.order("RANDOM()").first
  )
end

# Créer des patients
20.times do
  Patient.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    city: City.order("RANDOM()").first
  )
end

# Assigner des spécialités aux docteurs
Doctor.all.each do |doctor|
  specialties_sample = Specialty.order("RANDOM()").limit(rand(1..3))
  doctor.specialties << specialties_sample
end

# Créer des rendez-vous
50.times do
  Appointment.create!(
    date: Faker::Time.forward(days: 23, period: :day),
    doctor: Doctor.order("RANDOM()").first,
    patient: Patient.order("RANDOM()").first,
    city: City.order("RANDOM()").first
  )
end

puts "Données générées avec succès !"
