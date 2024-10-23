module Oodle
  class AnswersController < ApplicationController
    before_action :set_answer, only: %i[ show edit update destroy ]

    # GET /answers
    def index
      if Current.user.manager?
        @students = Current.user.students.pluck(:id, :email_address)
        @answers = Answer.where(user_id: @students[0])
      elsif Current.user.studend? || Current.user.user?
        @answers = Current.user.answers
      else
        @answers = Answer.all
      end

      @pagy, @answers = pagy(@answers)
    end

    # GET /answers/1
    def show
    end

    # GET /answers/new
    def new
      @questionnaire = Questionnaire.find(params[:questionnaire_id])
      @question = Question.find(params[:question_id])
      existing_answer = Answer.find_by(user_id: Current.user.id, question_id: @question.id, questionnaire_id: @questionnaire.id)

      if existing_answer
        flash[:notice] = "You have already responded to this question."
        redirect_to questionnaire_path(@questionnaire.id)
      else
        @answer = Answer.new(user_id: Current.user.id, questionnaire_id: @questionnaire.id, question_id: @question.id)
      end
    end

    # POST /answers or /answers.json
    def create
      @answer = Current.user.answers.new(answer_params)
      @answer.answered_at = Time.zone.now
      question = Question.find(@answer.question_id)

      if params[:commit].eql? :next
        @answer.result = { answer: "not responded" }
      elsif question.free_text?
        @answer.result = { answer: params[:answer][:result] }
      else
        @answer.result = {
          selected: params[:answer][:result] || [],
          all: question.items.map(&:display_value)
        }
      end

      respond_to do |format|
        if @answer.save
          format.html { redirect_to questionnaire_path(@answer.questionnaire.id), notice: "Answer was successfully created." }
          format.json { render :show, status: :created, location: @answer }
        else
          format.html { render :new }
          format.json { render json: @answer.errors, status: :unprocessable_entity }
        end
      end
    end

    # GET /answers/1/edit
    def edit
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

    def mark_as_completed
      questionnaire = Questionnaire.find(params[:id])
      Current.user.user_questionnaires
             .find_by(questionnaire_id: questionnaire.id)
             .mark_as_completed

      redirect_to questionnaire_path(questionnaire.id), notice: "Questionnaire completed"
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
