class Manufacturer < ActiveRecord::Base
  include Product
  CATEGORIES = { bike: 'Велосипед', kidsbike: 'Детский велосипед', trike: 'Трайк', kickscooter: 'Самокат',
                sled: 'Санки', icesled: 'Ледянка', snowroll: 'Снегокат', tubing: 'Тюбинг', 
                electriccar: 'Электромобиль', ski: 'Лыжи'}
  has_many :bikes, dependent: :destroy
  has_many :kidsbikes, dependent: :destroy
  has_many :kickscooters, dependent: :destroy
  has_many :icesleds, dependent: :destroy
  has_many :sleds, dependent: :destroy
  has_many :snowrolls, dependent: :destroy
  has_many :tubings, dependent: :destroy
  has_many :electriccars, dependent: :destroy
  has_many :skis, dependent: :destroy

  alias trikes kidsbikes
end