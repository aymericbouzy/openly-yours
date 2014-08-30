require 'test_helper'

class MesControllerTest < ActionController::TestCase
  setup do
    @me = mes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:mes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create me" do
    assert_difference('Me.count') do
      post :create, me: {  }
    end

    assert_redirected_to me_path(assigns(:me))
  end

  test "should show me" do
    get :show, id: @me
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @me
    assert_response :success
  end

  test "should update me" do
    patch :update, id: @me, me: {  }
    assert_redirected_to me_path(assigns(:me))
  end

  test "should destroy me" do
    assert_difference('Me.count', -1) do
      delete :destroy, id: @me
    end

    assert_redirected_to mes_path
  end
end
