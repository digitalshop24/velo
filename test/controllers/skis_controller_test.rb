require 'test_helper'

class SkisControllerTest < ActionController::TestCase
  setup do
    @ski = skis(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:skis)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ski" do
    assert_difference('Ski.count') do
      post :create, ski: { description: @ski.description, display: @ski.display, grid: @ski.grid, image: @ski.image, manufacturer_id: @ski.manufacturer_id, name: @ski.name, poles: @ski.poles, price: @ski.price, size: @ski.size }
    end

    assert_redirected_to ski_path(assigns(:ski))
  end

  test "should show ski" do
    get :show, id: @ski
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ski
    assert_response :success
  end

  test "should update ski" do
    patch :update, id: @ski, ski: { description: @ski.description, display: @ski.display, grid: @ski.grid, image: @ski.image, manufacturer_id: @ski.manufacturer_id, name: @ski.name, poles: @ski.poles, price: @ski.price, size: @ski.size }
    assert_redirected_to ski_path(assigns(:ski))
  end

  test "should destroy ski" do
    assert_difference('Ski.count', -1) do
      delete :destroy, id: @ski
    end

    assert_redirected_to skis_path
  end
end
