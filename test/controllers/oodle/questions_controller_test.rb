require "test_helper"

module Oodle
  class QuestionsControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    setup do
      @question = oodle_questions(:one)
    end

    test "should get index" do
      get questions_url
      assert_response :success
    end

    test "should get new" do
      get new_question_url
      assert_response :success
    end

    test "should create question" do
      assert_difference("Question.count") do
        post questions_url, params: { question: { description: @question.description, name: @question.name, question_type: @question.question_type, scorable: @question.scorable, score: @question.score } }
      end

      assert_redirected_to question_url(Question.last)
    end

    test "should show question" do
      get question_url(@question)
      assert_response :success
    end

    test "should get edit" do
      get edit_question_url(@question)
      assert_response :success
    end

    test "should update question" do
      patch question_url(@question), params: { question: { description: @question.description, name: @question.name, question_type: @question.question_type, scorable: @question.scorable, score: @question.score } }
      assert_redirected_to question_url(@question)
    end

    test "should destroy question" do
      assert_difference("Question.count", -1) do
        delete question_url(@question)
      end

      assert_redirected_to questions_url
    end
  end
end
