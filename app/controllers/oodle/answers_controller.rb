module Oodle
  class AnswersController < ApplicationController
    before_action :set_answer, only: %i[ show edit update destroy ]

    # GET /answers
    def index
      @answers = Answer.all
    end

    # GET /answers/1
    def show
    end

    # GET /answers/new
    def new
      @answer = Answer.new
    end

    # GET /answers/1/edit
    def edit
    end

    # POST /answers
    def create
      @answer = Answer.new(answer_params)

      if @answer.save
        redirect_to @answer, notice: "Answer was successfully created."
      else
        render :new, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /answers/1
    def update
      if @answer.update(answer_params)
        redirect_to @answer, notice: "Answer was successfully updated.", status: :see_other
      else
        render :edit, status: :unprocessable_entity
      end
    end

    # DELETE /answers/1
    def destroy
      @answer.destroy!
      redirect_to answers_path, notice: "Answer was successfully destroyed.", status: :see_other
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_answer
        @answer = Answer.find(params.expect(:id))
      end

      # Only allow a list of trusted parameters through.
      def answer_params
        params.expect(answer: [ :user_id, :answered_at, :result, :score, :questionnaire_id, :question_id ])
      end
  end
end
