require 'test_helper'

class ExtrafeesControllerTest < ActionController::TestCase
  setup do
    @student = students(:one)
    @extrafee = extrafees(:one)
  end

  test "should get index" do
    get :index, params: { student_id: @student }
    assert_response :success
  end

  test "should get new" do
    get :new, params: { student_id: @student }
    assert_response :success
  end

  test "should create extrafee" do
    assert_difference('Extrafee.count') do
      post :create, params: { student_id: @student, extrafee: @extrafee.attributes }
    end

    assert_redirected_to student_extrafee_path(@student, Extrafee.last)
  end

  test "should show extrafee" do
    get :show, params: { student_id: @student, id: @extrafee }
    assert_response :success
  end

  test "should get edit" do
    get :edit, params: { student_id: @student, id: @extrafee }
    assert_response :success
  end

  test "should update extrafee" do
    put :update, params: { student_id: @student, id: @extrafee, extrafee: @extrafee.attributes }
    assert_redirected_to student_extrafee_path(@student, Extrafee.last)
  end

  test "should destroy extrafee" do
    assert_difference('Extrafee.count', -1) do
      delete :destroy, params: { student_id: @student, id: @extrafee }
    end

    assert_redirected_to student_extrafees_path(@student)
  end
end
