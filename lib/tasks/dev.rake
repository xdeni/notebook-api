namespace :dev do
  desc "Configura ambiente de dev."
  task setup: :environment do

    %x(rails db:drop db:create db:migrate)

    ####################################

    kinds = %w(Amigo Comercial Conhecido)

    kinds.each do |kind|
      Kind.find_or_create_by(title: kind)
    end

    ####################################

    100.times do
      Contact.find_or_create_by!(
        name: Faker::Name.name,
        email: Faker::Internet.email,
        birthdate: Faker::Date.between(65.years.ago, 18.years.ago),
        kind: Kind.all.sample
      )
    end

    ####################################

    Contact.all.each do |contact|
      Random.rand(4).times do
        phone = Phone.create!(number: Faker::PhoneNumber.cell_phone)
        contact.phones << phone
        contact.save!
      end
    end

    ####################################

    Contact.all.each do |contact|
      Address.create!(
        street: Faker::Address.street_address,
        city: Faker::Address.city,
        contact: contact
      )
    end
  end

end
