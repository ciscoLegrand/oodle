require "application_system_test_case"

module Oodle
  class AnswersTest < ApplicationSystemTestCase
    setup do
      @answer = oodle_answers(:one)
    end

    test "visiting the index" do
      visit answers_url
      assert_selector "h1", text: "Answers"
    end

    test "should create answer" do
      visit answers_url
      click_on "New answer"

      fill_in "Answered at", with: @answer.answered_at
      fill_in "Assignment", with: @answer.assignment_id
      fill_in "Question", with: @answer.question_id
      fill_in "Result", with: @answer.result
      fill_in "Score", with: @answer.score
      fill_in "User", with: @answer.user_id
      click_on "Create Answer"

      assert_text "Answer was successfully created"
      click_on "Back"
    end

    test "should update Answer" do
      visit answer_url(@answer)
      click_on "Edit this answer", match: :first

      fill_in "Answered at", with: @answer.answered_at
      fill_in "Assignment", with: @answer.assignment_id
      fill_in "Question", with: @answer.question_id
      fill_in "Result", with: @answer.result
      fill_in "Score", with: @answer.score
      fill_in "User", with: @answer.user_id
      click_on "Update Answer"

      assert_text "Answer was successfully updated"
      click_on "Back"
    end

    test "should destroy Answer" do
      visit answer_url(@answer)
      click_on "Destroy this answer", match: :first

      assert_text "Answer was successfully destroyed"
    end
  end
end
