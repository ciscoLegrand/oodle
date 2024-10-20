module Oodle
  class QuestionnairesController < ApplicationController
    before_action :set_questionnaire, only: %i[ show edit update destroy ]

    # GET /questionnaires
    def index
      @questionnaires = Questionnaire.all
    end

    # GET /questionnaires/1
    def show
    end

    # GET /questionnaires/new
    def new
      @questionnaire = Questionnaire.new
    end

    # GET /questionnaires/1/edit
    def edit
    end

    # POST /questionnaires
    def create
      @questionnaire = Questionnaire.new(questionnaire_params)

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
        params.expect(questionnaire: [ :name, :start_date, :end_date, :duration, :manager_id ])
      end
  end
end
