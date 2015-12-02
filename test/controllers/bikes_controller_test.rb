require 'test_helper'

class BikesControllerTest < ActionController::TestCase
  setup do
    @bike = bikes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bikes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bike" do
    assert_difference('Bike.count') do
      post :create, bike: { absorber_length: @bike.absorber_length, amortization_type: @bike.amortization_type, basket: @bike.basket, bike_class: @bike.bike_class, bike_type: @bike.bike_type, brake_disks_diameter: @bike.brake_disks_diameter, carriage: @bike.carriage, chain: @bike.chain, chain_protection: @bike.chain_protection, crank_system: @bike.crank_system, description: @bike.description, double_rims: @bike.double_rims, folding_frame: @bike.folding_frame, footboard: @bike.footboard, fork: @bike.fork, fork_locking: @bike.fork_locking, fork_rod_diameter: @bike.fork_rod_diameter, fork_type: @bike.fork_type, frame_color: @bike.frame_color, frame_material: @bike.frame_material, frame_type: @bike.frame_type, front_brake: @bike.front_brake, front_break_type: @bike.front_break_type, front_derailleur: @bike.front_derailleur, front_fender: @bike.front_fender, front_hub: @bike.front_hub, grips: @bike.grips, grips_model: @bike.grips_model, handlebar: @bike.handlebar, handlebar_type: @bike.handlebar_type, handlebar_width: @bike.handlebar_width, horn: @bike.horn, image: @bike.image, light: @bike.light, luggage_rack: @bike.luggage_rack, manufacturer_id: @bike.manufacturer_id, name: @bike.name, pedal_material: @bike.pedal_material, pedal_type: @bike.pedal_type, pomp: @bike.pomp, price: @bike.price, ratchet: @bike.ratchet, rear_absorber: @bike.rear_absorber, rear_brake: @bike.rear_brake, rear_brake_type: @bike.rear_brake_type, rear_derailleur: @bike.rear_derailleur, rear_fender: @bike.rear_fender, rear_hub: @bike.rear_hub, rearview_mirror: @bike.rearview_mirror, rims: @bike.rims, rims_material: @bike.rims_material, roga: @bike.roga, saddle: @bike.saddle, saddle_amortization: @bike.saddle_amortization, saddle_type: @bike.saddle_type, shifters: @bike.shifters, shifters_type: @bike.shifters_type, speeds_number: @bike.speeds_number, stars_number_cassette: @bike.stars_number_cassette, stars_number_system: @bike.stars_number_system, teeth_number_cassette: @bike.teeth_number_cassette, teeth_number_system: @bike.teeth_number_system, tires: @bike.tires, tires_width: @bike.tires_width, transmission_type: @bike.transmission_type, tread: @bike.tread, weight: @bike.weight, wheels_diameter: @bike.wheels_diameter, year: @bike.year }
    end

    assert_redirected_to bike_path(assigns(:bike))
  end

  test "should show bike" do
    get :show, id: @bike
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bike
    assert_response :success
  end

  test "should update bike" do
    patch :update, id: @bike, bike: { absorber_length: @bike.absorber_length, amortization_type: @bike.amortization_type, basket: @bike.basket, bike_class: @bike.bike_class, bike_type: @bike.bike_type, brake_disks_diameter: @bike.brake_disks_diameter, carriage: @bike.carriage, chain: @bike.chain, chain_protection: @bike.chain_protection, crank_system: @bike.crank_system, description: @bike.description, double_rims: @bike.double_rims, folding_frame: @bike.folding_frame, footboard: @bike.footboard, fork: @bike.fork, fork_locking: @bike.fork_locking, fork_rod_diameter: @bike.fork_rod_diameter, fork_type: @bike.fork_type, frame_color: @bike.frame_color, frame_material: @bike.frame_material, frame_type: @bike.frame_type, front_brake: @bike.front_brake, front_break_type: @bike.front_break_type, front_derailleur: @bike.front_derailleur, front_fender: @bike.front_fender, front_hub: @bike.front_hub, grips: @bike.grips, grips_model: @bike.grips_model, handlebar: @bike.handlebar, handlebar_type: @bike.handlebar_type, handlebar_width: @bike.handlebar_width, horn: @bike.horn, image: @bike.image, light: @bike.light, luggage_rack: @bike.luggage_rack, manufacturer_id: @bike.manufacturer_id, name: @bike.name, pedal_material: @bike.pedal_material, pedal_type: @bike.pedal_type, pomp: @bike.pomp, price: @bike.price, ratchet: @bike.ratchet, rear_absorber: @bike.rear_absorber, rear_brake: @bike.rear_brake, rear_brake_type: @bike.rear_brake_type, rear_derailleur: @bike.rear_derailleur, rear_fender: @bike.rear_fender, rear_hub: @bike.rear_hub, rearview_mirror: @bike.rearview_mirror, rims: @bike.rims, rims_material: @bike.rims_material, roga: @bike.roga, saddle: @bike.saddle, saddle_amortization: @bike.saddle_amortization, saddle_type: @bike.saddle_type, shifters: @bike.shifters, shifters_type: @bike.shifters_type, speeds_number: @bike.speeds_number, stars_number_cassette: @bike.stars_number_cassette, stars_number_system: @bike.stars_number_system, teeth_number_cassette: @bike.teeth_number_cassette, teeth_number_system: @bike.teeth_number_system, tires: @bike.tires, tires_width: @bike.tires_width, transmission_type: @bike.transmission_type, tread: @bike.tread, weight: @bike.weight, wheels_diameter: @bike.wheels_diameter, year: @bike.year }
    assert_redirected_to bike_path(assigns(:bike))
  end

  test "should destroy bike" do
    assert_difference('Bike.count', -1) do
      delete :destroy, id: @bike
    end

    assert_redirected_to bikes_path
  end
end
