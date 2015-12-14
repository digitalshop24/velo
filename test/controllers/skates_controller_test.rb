require 'test_helper'

class SkatesControllerTest < ActionController::TestCase
  setup do
    @skate = skates(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:skates)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create skate" do
    assert_difference('Skate.count') do
      post :create, skate: { display: @skate.display, hit: @skate.hit, image: @skate.image, manufacturer_id: @skate.manufacturer_id, name: @skate.name, price: @skate.price, text: @skate.text }
    end

    assert_redirected_to skate_path(assigns(:skate))
  end

  test "should show skate" do
    get :show, id: @skate
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @skate
    assert_response :success
  end

  test "should update skate" do
    patch :update, id: @skate, skate: { display: @skate.display, hit: @skate.hit, image: @skate.image, manufacturer_id: @skate.manufacturer_id, name: @skate.name, price: @skate.price, text: @skate.text }
    assert_redirected_to skate_path(assigns(:skate))
  end

  test "should destroy skate" do
    assert_difference('Skate.count', -1) do
      delete :destroy, id: @skate
    end

    assert_redirected_to skates_path
  end
end
