require 'test_helper'

class KidsbikesControllerTest < ActionController::TestCase
  setup do
    @kidsbike = kidsbikes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:kidsbikes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create kidsbike" do
    assert_difference('Kidsbike.count') do
      post :create, kidsbike: { attached_wheels: @kidsbike.attached_wheels, bag: @kidsbike.bag, basket: @kidsbike.basket, chain_protection: @kidsbike.chain_protection, control_handle: @kidsbike.control_handle, flag: @kidsbike.flag, folding_frame: @kidsbike.folding_frame, footboard: @kidsbike.footboard, fork: @kidsbike.fork, fork_type: @kidsbike.fork_type, frame_color: @kidsbike.frame_color, frame_material: @kidsbike.frame_material, front_brake_type: @kidsbike.front_brake_type, front_fender: @kidsbike.front_fender, front_wheel_diameter: @kidsbike.front_wheel_diameter, handle: @kidsbike.handle, horn: @kidsbike.horn, image: @kidsbike.image, light: @kidsbike.light, luggage_rack: @kidsbike.luggage_rack, manufacturer_id: @kidsbike.manufacturer_id, music_unit: @kidsbike.music_unit, name: @kidsbike.name, pomp: @kidsbike.pomp, raincoat: @kidsbike.raincoat, rear_brake_type: @kidsbike.rear_brake_type, rear_derailleur: @kidsbike.rear_derailleur, rear_fender: @kidsbike.rear_fender, rear_wheels_stopper: @kidsbike.rear_wheels_stopper, rearview_mirror: @kidsbike.rearview_mirror, recommended_age: @kidsbike.recommended_age, safety_rim: @kidsbike.safety_rim, seat: @kidsbike.seat, seat_belts: @kidsbike.seat_belts, shifters: @kidsbike.shifters, shifters_type: @kidsbike.shifters_type, speeds_number: @kidsbike.speeds_number, use: @kidsbike.use, visor: @kidsbike.visor, weight: @kidsbike.weight, wheels_diameter: @kidsbike.wheels_diameter, wheels_number: @kidsbike.wheels_number, wheels_type: @kidsbike.wheels_type }
    end

    assert_redirected_to kidsbike_path(assigns(:kidsbike))
  end

  test "should show kidsbike" do
    get :show, id: @kidsbike
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @kidsbike
    assert_response :success
  end

  test "should update kidsbike" do
    patch :update, id: @kidsbike, kidsbike: { attached_wheels: @kidsbike.attached_wheels, bag: @kidsbike.bag, basket: @kidsbike.basket, chain_protection: @kidsbike.chain_protection, control_handle: @kidsbike.control_handle, flag: @kidsbike.flag, folding_frame: @kidsbike.folding_frame, footboard: @kidsbike.footboard, fork: @kidsbike.fork, fork_type: @kidsbike.fork_type, frame_color: @kidsbike.frame_color, frame_material: @kidsbike.frame_material, front_brake_type: @kidsbike.front_brake_type, front_fender: @kidsbike.front_fender, front_wheel_diameter: @kidsbike.front_wheel_diameter, handle: @kidsbike.handle, horn: @kidsbike.horn, image: @kidsbike.image, light: @kidsbike.light, luggage_rack: @kidsbike.luggage_rack, manufacturer_id: @kidsbike.manufacturer_id, music_unit: @kidsbike.music_unit, name: @kidsbike.name, pomp: @kidsbike.pomp, raincoat: @kidsbike.raincoat, rear_brake_type: @kidsbike.rear_brake_type, rear_derailleur: @kidsbike.rear_derailleur, rear_fender: @kidsbike.rear_fender, rear_wheels_stopper: @kidsbike.rear_wheels_stopper, rearview_mirror: @kidsbike.rearview_mirror, recommended_age: @kidsbike.recommended_age, safety_rim: @kidsbike.safety_rim, seat: @kidsbike.seat, seat_belts: @kidsbike.seat_belts, shifters: @kidsbike.shifters, shifters_type: @kidsbike.shifters_type, speeds_number: @kidsbike.speeds_number, use: @kidsbike.use, visor: @kidsbike.visor, weight: @kidsbike.weight, wheels_diameter: @kidsbike.wheels_diameter, wheels_number: @kidsbike.wheels_number, wheels_type: @kidsbike.wheels_type }
    assert_redirected_to kidsbike_path(assigns(:kidsbike))
  end

  test "should destroy kidsbike" do
    assert_difference('Kidsbike.count', -1) do
      delete :destroy, id: @kidsbike
    end

    assert_redirected_to kidsbikes_path
  end
end
