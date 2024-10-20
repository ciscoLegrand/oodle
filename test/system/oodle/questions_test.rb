require "application_system_test_case"

module Oodle
  class QuestionsTest < ApplicationSystemTestCase
    setup do
      @question = oodle_questions(:one)
    end

    test "visiting the index" do
      visit questions_url
      assert_selector "h1", text: "Questions"
    end

    test "should create question" do
      visit questions_url
      click_on "New question"

      fill_in "Description", with: @question.description
      fill_in "Name", with: @question.name
      fill_in "Question type", with: @question.question_type
      check "Scorable" if @question.scorable
      fill_in "Score", with: @question.score
      click_on "Create Question"

      assert_text "Question was successfully created"
      click_on "Back"
    end

    test "should update Question" do
      visit question_url(@question)
      click_on "Edit this question", match: :first

      fill_in "Description", with: @question.description
      fill_in "Name", with: @question.name
      fill_in "Question type", with: @question.question_type
      check "Scorable" if @question.scorable
      fill_in "Score", with: @question.score
      click_on "Update Question"

      assert_text "Question was successfully updated"
      click_on "Back"
    end

    test "should destroy Question" do
      visit question_url(@question)
      click_on "Destroy this question", match: :first

      assert_text "Question was successfully destroyed"
    end
  end
end
