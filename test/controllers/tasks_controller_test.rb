require 'test_helper'

class TasksControllerTest < ActionDispatch::IntegrationTest
  test "should get list" do
    get tasks_list_url
    assert_response :redirect
  end

end
