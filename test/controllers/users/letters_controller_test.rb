require 'test_helper'

class Users::LettersControllerTest < ActionController::TestCase
  setup do
    @users_letter = users_letters(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users_letters)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create users_letter" do
    assert_difference('Users::Letter.count') do
      post :create, users_letter: {  }
    end

    assert_redirected_to users_letter_path(assigns(:users_letter))
  end

  test "should show users_letter" do
    get :show, id: @users_letter
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @users_letter
    assert_response :success
  end

  test "should update users_letter" do
    patch :update, id: @users_letter, users_letter: {  }
    assert_redirected_to users_letter_path(assigns(:users_letter))
  end

  test "should destroy users_letter" do
    assert_difference('Users::Letter.count', -1) do
      delete :destroy, id: @users_letter
    end

    assert_redirected_to users_letters_path
  end
end
