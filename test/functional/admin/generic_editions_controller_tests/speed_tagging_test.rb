require 'test_helper'

class Admin::GenericEditionsController::SpeedTaggingTest < ActionController::TestCase
  setup do
    login_as :writer
  end

  test "should show the document when 'Save' is clicked" do
    edition = create(:edition, :imported)

    put :update, id: edition, speed_save: 1, edition: {
      title: "new-title",
      body: "new-body"
    }

    assert edition.reload.imported?
    assert_redirected_to admin_edition_path(edition)
  end

  test "re-renders the show page when there are errors during speed tagging update" do
    imported_edition = create(:edition, :imported, title: 'News article')
    put :update, id: imported_edition, speed_save: 'Save', edition: { title: '' }

    assert_response :success
    assert_template :show
    assert_equal 'News article', imported_edition.reload.title
  end
end