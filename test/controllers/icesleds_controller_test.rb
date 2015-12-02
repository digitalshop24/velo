require 'test_helper'

class IcesledsControllerTest < ActionController::TestCase
  setup do
    @icesled = icesleds(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:icesleds)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create icesled" do
    assert_difference('Icesled.count') do
      post :create, icesled: { description: @icesled.description, display: @icesled.display, handles: @icesled.handles, image: @icesled.image, length: @icesled.length, manufacturer_id: @icesled.manufacturer_id, material: @icesled.material, name: @icesled.name }
    end

    assert_redirected_to icesled_path(assigns(:icesled))
  end

  test "should show icesled" do
    get :show, id: @icesled
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @icesled
    assert_response :success
  end

  test "should update icesled" do
    patch :update, id: @icesled, icesled: { description: @icesled.description, display: @icesled.display, handles: @icesled.handles, image: @icesled.image, length: @icesled.length, manufacturer_id: @icesled.manufacturer_id, material: @icesled.material, name: @icesled.name }
    assert_redirected_to icesled_path(assigns(:icesled))
  end

  test "should destroy icesled" do
    assert_difference('Icesled.count', -1) do
      delete :destroy, id: @icesled
    end

    assert_redirected_to icesleds_path
  end
end
