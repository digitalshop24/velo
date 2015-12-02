require 'test_helper'

class ElectriccarsControllerTest < ActionController::TestCase
  setup do
    @electriccar = electriccars(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:electriccars)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create electriccar" do
    assert_difference('Electriccar.count') do
      post :create, electriccar: { age: @electriccar.age, battery: @electriccar.battery, charging_time: @electriccar.charging_time, description: @electriccar.description, engine: @electriccar.engine, image: @electriccar.image, light: @electriccar.light, manufacturer_id: @electriccar.manufacturer_id, max_speed: @electriccar.max_speed, max_weight: @electriccar.max_weight, name: @electriccar.name, price: @electriccar.price, rearview_mirror: @electriccar.rearview_mirror, remote_control: @electriccar.remote_control, seat_belt: @electriccar.seat_belt, sizes: @electriccar.sizes, weight: @electriccar.weight, work_time: @electriccar.work_time }
    end

    assert_redirected_to electriccar_path(assigns(:electriccar))
  end

  test "should show electriccar" do
    get :show, id: @electriccar
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @electriccar
    assert_response :success
  end

  test "should update electriccar" do
    patch :update, id: @electriccar, electriccar: { age: @electriccar.age, battery: @electriccar.battery, charging_time: @electriccar.charging_time, description: @electriccar.description, engine: @electriccar.engine, image: @electriccar.image, light: @electriccar.light, manufacturer_id: @electriccar.manufacturer_id, max_speed: @electriccar.max_speed, max_weight: @electriccar.max_weight, name: @electriccar.name, price: @electriccar.price, rearview_mirror: @electriccar.rearview_mirror, remote_control: @electriccar.remote_control, seat_belt: @electriccar.seat_belt, sizes: @electriccar.sizes, weight: @electriccar.weight, work_time: @electriccar.work_time }
    assert_redirected_to electriccar_path(assigns(:electriccar))
  end

  test "should destroy electriccar" do
    assert_difference('Electriccar.count', -1) do
      delete :destroy, id: @electriccar
    end

    assert_redirected_to electriccars_path
  end
end
