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

  task parse_prices: :environment do
    categories = []
    category_names = ['велосипед', 'детский велосипед', 'самокат'].each do |c|
      cat = search_category(c)[:category_key]
      if cat == 'kidsbike'
        categories << { category: 'kidsbike', category_key: cat, params: "num_wheels[0]=4&num_wheels[1]=2&num_wheels[operation]=union" }
        categories << { category: 'trike', category_key: cat, params: "num_wheels[0]=3&num_wheels[1]=2&num_wheels[operation]=union" }
      else
        categories << { category: cat, category_key: cat }
      end
    end
    categories.each do |category|
      category_key = category[:category_key]
      pages = pages_count(category_key)
      1.upto pages[:last] do |page|
        uri = "https://catalog.api.onliner.by/search/#{category_key}?page=#{page}&#{category[:params]}"
        tries = 0
        json = begin
          open(uri).read
        rescue => error
          puts("ERROR ===>> #{error.class} and #{error.message}")
          sleep(2)
          tries += 1
          retry if tries < 5
        end
        parsed = JSON.parse(json)
        parsed["products"].each do |product|
          manufacturer = get_manufacturer(product, category[:category])
          ar_product = manufacturer.send(category[:category].pluralize.to_sym).find_by(name: product['name'])
          if ar_product
            ar_product.onliner_key = product['key']
            ar_product.old_onliner_price = ar_product.onliner_price
            ar_product.onliner_price = product['prices']['min'] if product['prices'] && product['prices']['min']
            ar_product.save if ar_product.changed?
          end
        end
        puts "page #{page}/#{pages[:last]} #{category[:category]} done"
      end
    end
  end

  task :parse_help => :environment do |t, args|
    categories = ['велосипед', 'детский велосипед', 'самокат'].map{|c| search_category(c)[:category_key]}
    categories.each do |category|
      pairs = PAIRS[category]
      pages = 5
      1.upto pages do |page|
        puts "PAGE: #{page}/#{pages}"
        uri = "https://catalog.api.onliner.by/search/#{category}?page=#{page}"
        json = open(uri).read
        parsed = JSON.parse(json)

        parsed["products"].each_with_index do |product, index|
          doc = get_doc(product["html_url"])
          table = get_table(doc)
          table.css('.product-tip__content').each do |tip|
            key = tip.xpath('p').first.content.strip
            value = tip.xpath('p').last.content.strip.gsub(/\n/, '<br>' )
            dbtip = Tip.where(category: category, key: pairs[key]).first
            unless dbtip
              Tip.create(category: category, key: pairs[key], value: value)
              count = Tip.where(category: category).count
              puts "#{count.ordinalize} tip fot #{category}"
            end
          end
        end
      end
      puts "#{category} done!!!"
    end
  end

  def save(category, product, specifications)
    case category
    when 'kickscooter'
      item = Kickscooter.new
      pairs = PAIRS['kickscooter']
    when 'bike'
      item = Bike.new
      if specifications["Женский велосипед"]
        item.bike_type = "женский"
      elsif specifications["Подростковый велосипед"]
        item.bike_type = "подростковый"
      else
        item.bike_type = "мужской"
      end
      pairs = PAIRS['bike']

    when 'kidsbike'
      if specifications["Количество колёс"].to_i == 3
        item = Trike.new
        category = 'trike'
      else
        item = Kidsbike.new
        category = 'kidsbike'
      end
      pairs = PAIRS['kidsbike']
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
    pairs.keys.each do |key|
      item[pairs[key]] = specifications[key]
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
    tries = 0
    json = begin
      open(category_uri).read
    rescue => error
      puts("ERROR ===>> #{error.class} and #{error.message}")
      sleep(2)
      tries += 1
      retry if tries < 5
    end
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

PAIRS = {
  'kickscooter' => {
    "Назначение" => :use ,
    "Электропривод" => :electric_drive ,
    "Макс. вес катающегося" => :max_weight ,
    "Количество колёс" => :wheels_number ,
    "Диаметр колёс" => :wheels_diameter ,
    "Толщина колёс" => :wheels_thickness ,
    "Материал колёс" => :wheels_material ,
    "Твёрдость колёс" => :wheels_hardness ,
    "Надувные колёса" => :inflatable_wheels ,
    "Подшипники" => :bearings ,
    "Материал платформы" => :platform_material ,
    "Складная конструкция" => :folding ,
    "Сиденье" => :seat ,
    "Амортизация" => :amortization ,
    "Передний тормоз" => :front_break ,
    "Задний тормоз" => :rear_break ,
    "Управление отклонением ручки" => :tilt_handle_control ,
    "Светодиоды в колёсах" => :wheels_luminodiodes ,
    "Минимальная высота руля" => :min_handlebar_height ,
    "Максимальная высота руля" => :max_handlebar_height ,
    "Длина платформы (деки)" => :platform_length ,
    "Ширина платформы (деки)" => :platform_width ,
    "Длина" => :length ,
    "Вес" => :weight ,
    "Звонок или клаксон" => :horn ,
    "Корзина" => :basket ,
    "Подножка" => :footboard ,
    "Ремень" => :belt
  },
  'bike' => {
    "Дата выхода на рынок" => :year ,
    "Класс" => :bike_class ,
    "Вес" => :weight ,
    "Тип рамы" => :frame_type ,
    "Руль" => :handlebar ,
    "Цепь" => :chain ,
    "Вилка" => :fork ,
    "Насос" => :pomp ,
    "Обода" => :rims ,
    "Седло" => :saddle ,
    "«Рога»" => :roga ,
    "Грипсы" => :grips ,
    "Фонарь" => :light ,
    "Каретка" => :carriage ,
    "Корзина" => :basket ,
    "Манетки" => :shifters ,
    "Тип руля" => :handlebar_type ,
    "Багажник" => :luggage_rack ,
    "Подножка" => :footboard ,
    "Покрышки" => :tires ,
    "Тип вилки" => :fork_type ,
    "Тип седла" => :saddle_type ,
    "Цвет рамы" => :frame_color ,
    "Защита цепи" => :chain_protection ,
    "Тип манеток" => :shifters_type ,
    "Тип педалей" => :pedal_type ,
    "Ширина руля" => :handlebar_width ,
    "Ширина шины" => :tires_width ,
    "Задний щиток" => :rear_fender ,
    "Модель грипс" => :grips_model ,
    "Двойные обода" => :double_rims ,
    "Диаметр колёс" => :wheels_diameter ,
    "Задний тормоз" => :rear_brake ,
    "Задняя втулка" => :rear_hub ,
    "Материал рамы" => :frame_material ,
    "Складная рама" => :folding_frame ,
    "Передний щиток" => :front_fender ,
    "Передняя втулка" => :front_hub ,
    "Передний тормоз" => :front_brake ,
    "Система шатунов" => :crank_system ,
    "Тип амортизации" => :amortization_type ,
    "Тип трансмиссии" => :transmission_type ,
    "Блокировка вилки" => :fork_locking ,
    "Материал ободьев" => :rims_material ,
    "Материал педалей" => :pedal_material ,
    "Ход амортизатора" => :absorber_length ,
    "Амортизация седла" => :saddle_amortization ,
    "Звонок или клаксон" => :horn ,
    "Задний амортизатор" => :rear_absorber ,
    "Рисунок протектора" => :tread ,
    "Диаметр штока вилки" => :fork_rod_diameter ,
    "Тип заднего тормоза" => :rear_brake_type ,
    "Зеркало заднего вида" => :rearview_mirror ,
    "Кассета или трещотка" => :ratchet ,
    "Задний переключатель" => :rear_derailleur ,
    "Количество скоростей" => :speeds_number ,
    "Тип переднего тормоза" => :front_break_type ,
    "Передний переключатель" => :front_derailleur ,
    "Диаметр тормозных дисков" => :brake_disks_diameter ,
    "Количество звезд в кассете" => :stars_number_cassette ,
    "Количество звезд в системе" => :stars_number_system ,
    "Количество зубьев в звездах кассеты" => :teeth_number_cassette ,
    "Количество зубьев в звездах системы" => :teeth_number_system
  },
  'kidsbike' => {
    "Рекомендуемый возраст" => :recommended_age ,
    "Назначение" => :use ,
    "Вес" => :weight ,
    "Сиденье" => :seat ,
    "Ремни безопасности" => :seat_belts ,
    "Ручка" => :handle ,
    "Управление ручкой" => :control_handle ,
    "Страховочный обод" => :safety_rim ,
    "Козырёк" => :visor ,
    "Музыкальный блок" => :music_unit ,
    "Материал рамы" => :frame_material ,
    "Складная рама" => :folding_frame ,
    "Цвет рамы" => :frame_color ,
    "Вилка" => :fork ,
    "Тип вилки" => :fork_type ,
    "Количество скоростей" => :speeds_number ,
    "Задний переключатель" => :rear_derailleur ,
    "Манетки" => :shifters ,
    "Тип манеток" => :shifters_type ,
    "Тип переднего тормоза" => :front_brake_type ,
    "Тип заднего тормоза" => :rear_brake_type ,
    "Количество колёс" => :wheels_number ,
    "Диаметр колёс" => :wheels_diameter ,
    "Диаметр переднего колеса" => :front_wheel_diameter ,
    "Приставные колеса" => :attached_wheels ,
    "Тип колёс" => :wheels_type ,
    "Стопор задних колёс" => :rear_wheels_stopper ,
    "Дождевик" => :raincoat ,
    "Передний щиток" => :front_fender ,
    "Задний щиток" => :rear_fender ,
    "Защита цепи" => :chain_protection ,
    "Багажник" => :luggage_rack ,
    "Зеркало заднего вида" => :rearview_mirror ,
    "Звонок или клаксон" => :horn ,
    "Корзина" => :basket ,
    "Сумка (рюкзак)" => :bag ,
    "Флажок" => :flag ,
    "Подножка" => :footboard ,
    "Фонарь" => :light ,
    "Насос" => :pomp
  }
}
