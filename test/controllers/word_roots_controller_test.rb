require 'test_helper'

class WordRootsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get word_roots_index_url
    assert_response :success
  end

  test "should get show" do
    get word_roots_show_url
    assert_response :success
  end

end
