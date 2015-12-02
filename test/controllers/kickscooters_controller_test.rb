require 'test_helper'

class KickscootersControllerTest < ActionController::TestCase
  setup do
    @kickscooter = kickscooters(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:kickscooters)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create kickscooter" do
    assert_difference('Kickscooter.count') do
      post :create, kickscooter: { amortization: @kickscooter.amortization, basket: @kickscooter.basket, bearings: @kickscooter.bearings, belt: @kickscooter.belt, description: @kickscooter.description, display: @kickscooter.display, electric_drive: @kickscooter.electric_drive, folding: @kickscooter.folding, footboard: @kickscooter.footboard, front_break: @kickscooter.front_break, horn: @kickscooter.horn, image: @kickscooter.image, inflatable_wheels: @kickscooter.inflatable_wheels, length: @kickscooter.length, manufacturer_id: @kickscooter.manufacturer_id, max_handlebar_height: @kickscooter.max_handlebar_height, max_weight: @kickscooter.max_weight, min_handlebar_height: @kickscooter.min_handlebar_height, name: @kickscooter.name, platform_length: @kickscooter.platform_length, platform_material: @kickscooter.platform_material, platform_width: @kickscooter.platform_width, price: @kickscooter.price, rear_break: @kickscooter.rear_break, seat: @kickscooter.seat, tilt_handle_control: @kickscooter.tilt_handle_control, use: @kickscooter.use, weight: @kickscooter.weight, wheels_diameter: @kickscooter.wheels_diameter, wheels_hardness: @kickscooter.wheels_hardness, wheels_luminodiodes: @kickscooter.wheels_luminodiodes, wheels_material: @kickscooter.wheels_material, wheels_number: @kickscooter.wheels_number, wheels_thickness: @kickscooter.wheels_thickness }
    end

    assert_redirected_to kickscooter_path(assigns(:kickscooter))
  end

  test "should show kickscooter" do
    get :show, id: @kickscooter
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @kickscooter
    assert_response :success
  end

  test "should update kickscooter" do
    patch :update, id: @kickscooter, kickscooter: { amortization: @kickscooter.amortization, basket: @kickscooter.basket, bearings: @kickscooter.bearings, belt: @kickscooter.belt, description: @kickscooter.description, display: @kickscooter.display, electric_drive: @kickscooter.electric_drive, folding: @kickscooter.folding, footboard: @kickscooter.footboard, front_break: @kickscooter.front_break, horn: @kickscooter.horn, image: @kickscooter.image, inflatable_wheels: @kickscooter.inflatable_wheels, length: @kickscooter.length, manufacturer_id: @kickscooter.manufacturer_id, max_handlebar_height: @kickscooter.max_handlebar_height, max_weight: @kickscooter.max_weight, min_handlebar_height: @kickscooter.min_handlebar_height, name: @kickscooter.name, platform_length: @kickscooter.platform_length, platform_material: @kickscooter.platform_material, platform_width: @kickscooter.platform_width, price: @kickscooter.price, rear_break: @kickscooter.rear_break, seat: @kickscooter.seat, tilt_handle_control: @kickscooter.tilt_handle_control, use: @kickscooter.use, weight: @kickscooter.weight, wheels_diameter: @kickscooter.wheels_diameter, wheels_hardness: @kickscooter.wheels_hardness, wheels_luminodiodes: @kickscooter.wheels_luminodiodes, wheels_material: @kickscooter.wheels_material, wheels_number: @kickscooter.wheels_number, wheels_thickness: @kickscooter.wheels_thickness }
    assert_redirected_to kickscooter_path(assigns(:kickscooter))
  end

  test "should destroy kickscooter" do
    assert_difference('Kickscooter.count', -1) do
      delete :destroy, id: @kickscooter
    end

    assert_redirected_to kickscooters_path
  end
end
