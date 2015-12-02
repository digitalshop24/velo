require 'open-uri'

namespace :db do
  task :parse, [:query, :start_page] => :environment do |t, args|
    category = search_category(args[:query])
    pages = pages_count(category[:category_key])
    if args[:start_page]
      start_page = args[:start_page].to_i
    else
      start_page = 1
    end
    start_page.upto pages[:last] do |page|
      uri = "https://catalog.api.onliner.by/search/#{category[:category_key]}?page=#{page}"
      json = open(uri).read
      parsed = JSON.parse(json)
      parsed["products"].each_with_index do |product, index|
        puts "#{(page - 1) * pages[:limit] + index + 1 }/#{category[:products_count]}".light_yellow
        doc = get_doc(product["html_url"])
        table = get_table(doc)
        item = save(category[:category_key], product, get_specifications(table))
        description = get_description(doc)
        item.description = description if description.size > 5
        save_gallery(item, doc)
      end
    end
  end

  def save(category, product, specifications)
    case category
    when 'kickscooter'
      item = Kickscooter.new
      pairs = [[:use, "Назначение"],
               [:electric_drive, "Электропривод"],
               [:max_weight, "Макс. вес катающегося"],
               [:wheels_number, "Количество колёс"],
               [:wheels_diameter, "Диаметр колёс"],
               [:wheels_thickness, "Толщина колёс"],
               [:wheels_material, "Материал колёс"],
               [:wheels_hardness, "Твёрдость колёс"],
               [:inflatable_wheels, "Надувные колёса"],
               [:bearings, "Подшипники"],
               [:platform_material, "Материал платформы"],
               [:folding, "Складная конструкция"],
               [:seat, "Сиденье"],
               [:amortization, "Амортизация"],
               [:front_break, "Передний тормоз"],
               [:rear_break, "Задний тормоз"],
               [:tilt_handle_control, "Управление отклонением ручки"],
               [:wheels_luminodiodes, "Светодиоды в колёсах"],
               [:min_handlebar_height, "Минимальная высота руля"],
               [:max_handlebar_height, "Максимальная высота руля"],
               [:platform_length, "Длина платформы (деки)"],
               [:platform_width, "Ширина платформы (деки)"],
               [:length, "Длина"],
               [:weight, "Вес"],
               [:horn, "Звонок или клаксон"],
               [:basket, "Корзина"],
               [:footboard, "Подножка"],
               [:belt, "Ремень"]
               ]
    when 'bike'
      item = Bike.new
      if specifications["Женский велосипед"]
        item.bike_type = "женский"
      elsif specifications["Подростковый велосипед"]
        item.bike_type = "подростковый"
      else
        item.bike_type = "мужской"
      end
      pairs = [[:year, "Дата выхода на рынок"],
               [:bike_class, "Класс"],
               [:weight, "Вес"],
               [:frame_type, "Тип рамы"],
               [:handlebar, "Руль"],
               [:handlebar, "Руль"],
               [:chain, "Цепь"],
               [:fork, "Вилка"],
               [:pomp, "Насос"],
               [:rims, "Обода"],
               [:saddle, "Седло"],
               [:roga, "«Рога»"],
               [:grips, "Грипсы"],
               [:light, "Фонарь"],
               [:carriage, "Каретка"],
               [:basket, "Корзина"],
               [:shifters, "Манетки"],
               [:handlebar_type, "Тип руля"],
               [:luggage_rack, "Багажник"],
               [:footboard, "Подножка"],
               [:tires, "Покрышки"],
               [:fork_type, "Тип вилки"],
               [:saddle_type, "Тип седла"],
               [:frame_color, "Цвет рамы"],
               [:chain_protection, "Защита цепи"],
               [:shifters_type, "Тип манеток"],
               [:pedal_type, "Тип педалей"],
               [:handlebar_width, "Ширина руля"],
               [:tires_width, "Ширина шины"],
               [:rear_fender, "Задний щиток"],
               [:grips_model, "Модель грипс"],
               [:double_rims, "Двойные обода"],
               [:wheels_diameter, "Диаметр колёс"],
               [:rear_brake, "Задний тормоз"],
               [:rear_hub, "Задняя втулка"],
               [:frame_material, "Материал рамы"],
               [:folding_frame, "Складная рама"],
               [:front_fender, "Передний щиток"],
               [:front_hub, "Передняя втулка"],
               [:front_brake, "Передний тормоз"],
               [:crank_system, "Система шатунов"],
               [:amortization_type, "Тип амортизации"],
               [:transmission_type, "Тип трансмиссии"],
               [:fork_locking, "Блокировка вилки"],
               [:rims_material, "Материал ободьев"],
               [:pedal_material, "Материал педалей"],
               [:absorber_length, "Ход амортизатора"],
               [:saddle_amortization, "Амортизация седла"],
               [:horn, "Звонок или клаксон"],
               [:rear_absorber, "Задний амортизатор"],
               [:tread, "Рисунок протектора"],
               [:fork_rod_diameter, "Диаметр штока вилки"],
               [:rear_brake_type, "Тип заднего тормоза"],
               [:rearview_mirror, "Зеркало заднего вида"],
               [:ratchet, "Кассета или трещотка"],
               [:rear_derailleur, "Задний переключатель"],
               [:speeds_number, "Количество скоростей"],
               [:front_break_type, "Тип переднего тормоза"],
               [:front_derailleur, "Передний переключатель"],
               [:brake_disks_diameter, "Диаметр тормозных дисков"],
               [:stars_number_cassette, "Количество звезд в кассете"],
               [:stars_number_system, "Количество звезд в системе"],
               [:teeth_number_cassette, "Количество зубьев в звездах кассеты"],
               [:teeth_number_system, "Количество зубьев в звездах системы"]
               ]

    when 'kidsbike'
      item = Kidsbike.new
      pairs = [[:recommended_age, "Рекомендуемый возраст"],
               [:use, "Назначение"],
               [:weight, "Вес"],
               [:seat, "Сиденье"],
               [:seat_belts, "Ремни безопасности"],
               [:handle, "Ручка"],
               [:control_handle, "Управление ручкой"],
               [:safety_rim, "Страховочный обод"],
               [:visor, "Козырёк"],
               [:music_unit, "Музыкальный блок"],
               [:frame_material, "Материал рамы"],
               [:folding_frame, "Складная рама"],
               [:frame_color, "Цвет рамы"],
               [:fork, "Вилка"],
               [:fork_type, "Тип вилки"],
               [:speeds_number, "Количество скоростей"],
               [:rear_derailleur, "Задний переключатель"],
               [:shifters, "Манетки"],
               [:shifters_type, "Тип манеток"],
               [:front_brake_type, "Тип переднего тормоза"],
               [:rear_brake_type, "Тип заднего тормоза"],
               [:wheels_number, "Количество колёс"],
               [:wheels_diameter, "Диаметр колёс"],
               [:front_wheel_diameter, "Диаметр переднего колеса"],
               [:attached_wheels, "Приставные колеса"],
               [:wheels_type, "Тип колёс"],
               [:rear_wheels_stopper, "Стопор задних колёс"],
               [:raincoat, "Дождевик"],
               [:front_fender, "Передний щиток"],
               [:rear_fender, "Задний щиток"],
               [:chain_protection, "Защита цепи"],
               [:luggage_rack, "Багажник"],
               [:rearview_mirror, "Зеркало заднего вида"],
               [:horn, "Звонок или клаксон"],
               [:basket, "Корзина"],
               [:bag, "Сумка (рюкзак)"],
               [:flag, "Флажок"],
               [:footboard, "Подножка"],
               [:light, "Фонарь"],
               [:pomp, "Насос"]
               ]
    end
    item = from_specification_to_columns(specifications, pairs, item)
    item.manufacturer = get_manufacturer(product, category)
    item.name = product["name"].gsub('&quot;', '')
    find = Object.const_get(item.class.name).find_by(manufacturer_id: item.manufacturer_id, name: item.name)
    unless find
      if item.save
        puts "#{product["full_name"]} saved :)".light_green
        item
      else
        puts "Smth went wrong".light_red
      end
    else
      puts "#{product["full_name"]} already exists".light_yellow
      find
    end
  end

  def save_gallery(item, doc)
    item.gallery ||= Gallery.new
    if item.gallery.images.size > 0
      puts "Images already exists".yellow
      return
    end
    gallery = get_gallery(doc)
    gallery.each do |image_url|
      item.gallery.images.create!(image: URI.parse(image_url))
    end
    item.update(image: item.gallery.images.first.image) if item.gallery.not_empty?
    puts "#{gallery.size} images downloaded".green
  end

  def from_specification_to_columns(specifications, pairs, item)
    pairs.each do |pair|
      item[pair[0]] = specifications[pair[1]]
    end
    item
  end

  def get_manufacturer(product, category)
    manufacturer = product["full_name"].gsub(product["name"], '').strip
    Manufacturer.where(name: manufacturer, category: category).first_or_create
  end

  def get_doc(url)
    html = open(url)
    Nokogiri::HTML(html)
  end

  def get_table(doc)
    doc.css('.product-specs__table')
  end

  def search_category(category_query)
    uri_schema = URI.escape("https://catalog.api.onliner.by/search/schemas?query=#{category_query}")
    json = open(uri_schema).read
    parsed = JSON.parse(json)
    schema = parsed["schemas"].first
    {"category_key": schema["key"], "products_count": schema["products_count"]}
  end

  def pages_count(category_key)
    category_uri = "https://catalog.api.onliner.by/search/#{category_key}"
    json = open(category_uri).read
    parsed = JSON.parse(json)
    { last: parsed["page"]["last"].to_i, limit: parsed["page"]["limit"].to_i }
  end

  def get_specifications(table)
    specifications = Hash.new
    table.xpath('tbody/tr').drop(1).each do |tr|
      tds = tr.xpath('td')
      tds.first.xpath('div').remove
      key = tds.first.content.strip
      unless key.empty?
        value_td = tds.last
        span_class = value_td.xpath('span').attr('class').to_s.strip
        # gsub!(/\s{2,}/, '')
        if span_class == 'i-tip'
          value = true
        elsif span_class == 'i-x'
          value = false
        else
          value = value_td.content.strip.gsub(/[[:space:]]+/, ' ')
          if key =~ /Количество|Дата|Год/
            value = value[/[[:digit:]]+/].to_i
          end
          if value =~ /[[:digit:]]+ мм|кг|см|\"/
            value = value[/[[:digit:]]+\.*[[:digit:]]*/].to_f
          end
          if key =~ /Цвет/
            value = value.split(', ')
          end
        end
        specifications[key] = value
      end
    end
    specifications
  end

  def get_description(doc)
    desc = doc.css('.product-specs__table-small').first
    if desc
      desc.xpath('p').first.content.strip
    else
      'no'
    end
  end

  def get_gallery(doc)
    images = []
    doc.css('.product-gallery__thumb').each do |thumb|
      images << thumb.attr('data-original')
    end
    images
  end

end
