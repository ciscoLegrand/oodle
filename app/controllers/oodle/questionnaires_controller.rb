module Oodle
  class QuestionnairesController < ApplicationController
    before_action :set_questionnaire, only: %i[ show edit update destroy ]

    # GET /questionnaires
    def index
      @questionnaires = Questionnaire.all unless params[:sorted].present?
      @questionnaires = Questionnaire.closed if params[:sorted].eql? "closed"
      @questionnaires = Questionnaire.opened if params[:sorted].eql? "open"
      @questionnaires = Questionnaire.pending if params[:sorted].eql? "pending"

      @pagy, @questionnaires = pagy(@questionnaires)
    end

    # GET /questionnaires/1
    def show
      @user_questionnaire = UserQuestionnaire.find_or_initialize_by(user: Current.user, questionnaire: @questionnaire)
      @user_questionnaire.subscribe unless @user_questionnaire.subscribed?
    end

    # GET /questionnaires/new
    def new
      @questionnaire = Questionnaire.new(start_date: Time.zone.now, end_date: Time.zone.now + 1.day)
      @free_text = [ "free_text", Question.free_text ]
      @simple = [ "simple", Question.simple ]
      @multiple = [ "multiple", Question.multiple ]
    end

    # GET /questionnaires/1/edit
    def edit
      @free_text = [ "free_text", Question.free_text ]
      @simple = [ "simple", Question.simple ]
      @multiple = [ "multiple", Question.multiple ]
    end

    # POST /questionnaires
    def create
      @questionnaire = Questionnaire.new(questionnaire_params.merge(manager: Current.user))

      if @questionnaire.save
        redirect_to @questionnaire, notice: "Questionnaire was successfully created."
      else
        render :new, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /questionnaires/1
    def update
      if @questionnaire.update(questionnaire_params)
        redirect_to @questionnaire, notice: "Questionnaire was successfully updated.", status: :see_other
      else
        render :edit, status: :unprocessable_entity
      end
    end

    # DELETE /questionnaires/1
    def destroy
      @questionnaire.destroy!
      redirect_to questionnaires_path, notice: "Questionnaire was successfully destroyed.", status: :see_other
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_questionnaire
        @questionnaire = Questionnaire.find(params.expect(:id))
      end

      # Only allow a list of trusted parameters through.
      def questionnaire_params
        params.expect(questionnaire: [ :name, :start_date, :end_date, :duration, :manager_id, question_ids: [] ])
      end
  end
end
