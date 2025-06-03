require "test_helper"

class HistoricoControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get historico_index_url
    assert_response :success
  end
end
