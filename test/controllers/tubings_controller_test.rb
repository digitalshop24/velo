require 'test_helper'

class TubingsControllerTest < ActionController::TestCase
  setup do
    @tubing = tubings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tubings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tubing" do
    assert_difference('Tubing.count') do
      post :create, tubing: { bottom_material: @tubing.bottom_material, description: @tubing.description, diameter: @tubing.diameter, display: @tubing.display, handles_type: @tubing.handles_type, manufacturer_id: @tubing.manufacturer_id, name: @tubing.name, top_material: @tubing.top_material, tow_rope: @tubing.tow_rope }
    end

    assert_redirected_to tubing_path(assigns(:tubing))
  end

  test "should show tubing" do
    get :show, id: @tubing
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tubing
    assert_response :success
  end

  test "should update tubing" do
    patch :update, id: @tubing, tubing: { bottom_material: @tubing.bottom_material, description: @tubing.description, diameter: @tubing.diameter, display: @tubing.display, handles_type: @tubing.handles_type, manufacturer_id: @tubing.manufacturer_id, name: @tubing.name, top_material: @tubing.top_material, tow_rope: @tubing.tow_rope }
    assert_redirected_to tubing_path(assigns(:tubing))
  end

  test "should destroy tubing" do
    assert_difference('Tubing.count', -1) do
      delete :destroy, id: @tubing
    end

    assert_redirected_to tubings_path
  end
end
