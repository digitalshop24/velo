require 'test_helper'

class SnowrollsControllerTest < ActionController::TestCase
  setup do
    @snowroll = snowrolls(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:snowrolls)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create snowroll" do
    assert_difference('Snowroll.count') do
      post :create, snowroll: { amortization: @snowroll.amortization, color: @snowroll.color, description: @snowroll.description, display: @snowroll.display, image: @snowroll.image, manufacturer_id: @snowroll.manufacturer_id, name: @snowroll.name, seat: @snowroll.seat }
    end

    assert_redirected_to snowroll_path(assigns(:snowroll))
  end

  test "should show snowroll" do
    get :show, id: @snowroll
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @snowroll
    assert_response :success
  end

  test "should update snowroll" do
    patch :update, id: @snowroll, snowroll: { amortization: @snowroll.amortization, color: @snowroll.color, description: @snowroll.description, display: @snowroll.display, image: @snowroll.image, manufacturer_id: @snowroll.manufacturer_id, name: @snowroll.name, seat: @snowroll.seat }
    assert_redirected_to snowroll_path(assigns(:snowroll))
  end

  test "should destroy snowroll" do
    assert_difference('Snowroll.count', -1) do
      delete :destroy, id: @snowroll
    end

    assert_redirected_to snowrolls_path
  end
end
