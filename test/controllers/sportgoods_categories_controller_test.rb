require 'test_helper'

class SportgoodsCategoriesControllerTest < ActionController::TestCase
  setup do
    @sportgoods_category = sportgoods_categories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sportgoods_categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sportgoods_category" do
    assert_difference('SportgoodsCategory.count') do
      post :create, sportgoods_category: { name: @sportgoods_category.name }
    end

    assert_redirected_to sportgoods_category_path(assigns(:sportgoods_category))
  end

  test "should show sportgoods_category" do
    get :show, id: @sportgoods_category
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sportgoods_category
    assert_response :success
  end

  test "should update sportgoods_category" do
    patch :update, id: @sportgoods_category, sportgoods_category: { name: @sportgoods_category.name }
    assert_redirected_to sportgoods_category_path(assigns(:sportgoods_category))
  end

  test "should destroy sportgoods_category" do
    assert_difference('SportgoodsCategory.count', -1) do
      delete :destroy, id: @sportgoods_category
    end

    assert_redirected_to sportgoods_categories_path
  end
end
