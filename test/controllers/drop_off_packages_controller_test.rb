require 'test_helper'

class DropOffPackagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @drop_off_package = drop_off_packages(:one)
  end

  test "should get index" do
    get drop_off_packages_url
    assert_response :success
  end

  test "should get new" do
    get new_drop_off_package_url
    assert_response :success
  end

  test "should create drop_off_package" do
    assert_difference('DropOffPackage.count') do
      post drop_off_packages_url, params: { drop_off_package: { tracking_ref: @drop_off_package.tracking_ref, user_id: @drop_off_package.user_id } }
    end

    assert_redirected_to drop_off_package_url(DropOffPackage.last)
  end

  test "should show drop_off_package" do
    get drop_off_package_url(@drop_off_package)
    assert_response :success
  end

  test "should get edit" do
    get edit_drop_off_package_url(@drop_off_package)
    assert_response :success
  end

  test "should update drop_off_package" do
    patch drop_off_package_url(@drop_off_package), params: { drop_off_package: { tracking_ref: @drop_off_package.tracking_ref, user_id: @drop_off_package.user_id } }
    assert_redirected_to drop_off_package_url(@drop_off_package)
  end

  test "should destroy drop_off_package" do
    assert_difference('DropOffPackage.count', -1) do
      delete drop_off_package_url(@drop_off_package)
    end

    assert_redirected_to drop_off_packages_url
  end
end
