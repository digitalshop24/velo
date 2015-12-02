json.array!(@kidsbikes) do |kidsbike|
  json.extract! kidsbike, :id, :name, :manufacturer_id, :image, :recommended_age, :use, :weight, :seat, :seat_belts, :handle, :control_handle, :safety_rim, :visor, :music_unit, :frame_material, :folding_frame, :frame_color, :fork, :fork_type, :speeds_number, :rear_derailleur, :shifters, :shifters_type, :front_brake_type, :rear_brake_type, :wheels_number, :wheels_diameter, :front_wheel_diameter, :attached_wheels, :wheels_type, :rear_wheels_stopper, :raincoat, :front_fender, :rear_fender, :chain_protection, :luggage_rack, :rearview_mirror, :horn, :basket, :bag, :flag, :footboard, :light, :pomp, :hit
  json.url kidsbike_url(kidsbike, format: :json)
end
