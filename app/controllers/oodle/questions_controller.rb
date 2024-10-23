module Oodle
  class QuestionsController < ApplicationController
    before_action :set_question, only: %i[ show edit update destroy ]

    # GET /questions
    def index
      if params[:sorted].eql?("all") || params[:sorted].blank?
        @questions = Question.all
      end
      @questions = Question.simple if params[:sorted].eql? "simple"
      @questions = Question.multiple if params[:sorted].eql? "multiple"
      @questions = Question.free_text if params[:sorted].eql? "free_text"

      @pagy, @questions = pagy(@questions)
    end

    # GET /questions/1
    def show
    end

    # GET /questions/new
    def new
      @question = Question.new
      # @questionnaire = Questionnaire.find(params[:questionnaire_id])
    end
    # GET /questions/1/edit
    def edit
    end

    # POST /questions
    def create
      # @questionnaire = Questionnaire.find(params[:questionnaire_id])
      @question = Question.new(question_params)

      respond_to do |format|
        if @question.save
          format.html { redirect_to @question, notice: "Question was successfully created." }
          format.json { render :show, status: :created, location: @question }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @question.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /questions/1
    def update
      if @question.update(question_params)
        redirect_to @question, notice: "Question was successfully updated.", status: :see_other
      else
        render :edit, status: :unprocessable_entity
      end
    end

    # DELETE /questions/1
    def destroy
      @question.destroy!
      redirect_to questions_path, notice: "Question was successfully destroyed.", status: :see_other
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_question
        @question = Question.find(params.expect(:id))
      end

      # Only allow a list of trusted parameters through.
      def question_params
        params.expect(question: [ :name, :description, :question_type, :scorable, :score,
                                  question_item_ids: [] ])
      end
  end
end
