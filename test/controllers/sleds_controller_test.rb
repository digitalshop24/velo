require 'test_helper'

class SledsControllerTest < ActionController::TestCase
  setup do
    @sled = sleds(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sleds)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sled" do
    assert_difference('Sled.count') do
      post :create, sled: { backrest_adjustment: @sled.backrest_adjustment, bag: @sled.bag, color: @sled.color, description: @sled.description, display: @sled.display, flicker: @sled.flicker, folding_visor: @sled.folding_visor, folding_visor_type: @sled.folding_visor_type, image: @sled.image, legs_case: @sled.legs_case, manufacturer_id: @sled.manufacturer_id, name: @sled.name, runners_width: @sled.runners_width, seat_belt: @sled.seat_belt, seat_belt_type: @sled.seat_belt_type, transport_wheel: @sled.transport_wheel }
    end

    assert_redirected_to sled_path(assigns(:sled))
  end

  test "should show sled" do
    get :show, id: @sled
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sled
    assert_response :success
  end

  test "should update sled" do
    patch :update, id: @sled, sled: { backrest_adjustment: @sled.backrest_adjustment, bag: @sled.bag, color: @sled.color, description: @sled.description, display: @sled.display, flicker: @sled.flicker, folding_visor: @sled.folding_visor, folding_visor_type: @sled.folding_visor_type, image: @sled.image, legs_case: @sled.legs_case, manufacturer_id: @sled.manufacturer_id, name: @sled.name, runners_width: @sled.runners_width, seat_belt: @sled.seat_belt, seat_belt_type: @sled.seat_belt_type, transport_wheel: @sled.transport_wheel }
    assert_redirected_to sled_path(assigns(:sled))
  end

  test "should destroy sled" do
    assert_difference('Sled.count', -1) do
      delete :destroy, id: @sled
    end

    assert_redirected_to sleds_path
  end
end
