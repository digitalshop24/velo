require 'test_helper'

class SportgoodsSubcategoriesControllerTest < ActionController::TestCase
  setup do
    @sportgoods_subcategory = sportgoods_subcategories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sportgoods_subcategories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sportgoods_subcategory" do
    assert_difference('SportgoodsSubcategory.count') do
      post :create, sportgoods_subcategory: { name: @sportgoods_subcategory.name }
    end

    assert_redirected_to sportgoods_subcategory_path(assigns(:sportgoods_subcategory))
  end

  test "should show sportgoods_subcategory" do
    get :show, id: @sportgoods_subcategory
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sportgoods_subcategory
    assert_response :success
  end

  test "should update sportgoods_subcategory" do
    patch :update, id: @sportgoods_subcategory, sportgoods_subcategory: { name: @sportgoods_subcategory.name }
    assert_redirected_to sportgoods_subcategory_path(assigns(:sportgoods_subcategory))
  end

  test "should destroy sportgoods_subcategory" do
    assert_difference('SportgoodsSubcategory.count', -1) do
      delete :destroy, id: @sportgoods_subcategory
    end

    assert_redirected_to sportgoods_subcategories_path
  end
end
