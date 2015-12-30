namespace :db do
  task trike_types: :environment do
    Kidsbike.all.each do |kb|
      if (kb.wheels_number == 3)
        kb.update(bike_type: 'трайк')
      else
        kb.update(bike_type: 'детский')
      end
    end
  end
end
