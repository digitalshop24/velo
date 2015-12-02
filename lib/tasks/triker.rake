namespace :db do
  task :trike => :environment do
    Kidsbike.all.each do |kb|
      if (kb.wheels_number == 3)
        manufacturer_id = Manufacturer.where(name: kb.manufacturer.name, category: 'trike').first_or_create.id
        kb.update(manufacturer_id: manufacturer_id)
      end
    end
    Manufacturer.where(category: 'kidsbike').each do |m|
      m.destroy if m.kidsbikes.count == 0
    end 
  end
end
