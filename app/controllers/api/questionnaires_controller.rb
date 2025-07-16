# app/controllers/api/questionnaires_controller.rb
class Api::QuestionnairesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity

  def index
    render json: Questionnaire.all, status: :ok
  end

  def show
    questionnaire = Questionnaire.find(params[:id])
    render json: questionnaire, include: :questions, status: :ok
  end

  def create
    questionnaire = Questionnaire.create!(questionnaire_params)
    render json: questionnaire, status: :created
  end

  def update
    questionnaire = Questionnaire.find(params[:id])
    questionnaire.update!(questionnaire_params)
    render json: questionnaire, status: :ok
  end

  def destroy
    questionnaire = Questionnaire.find(params[:id])
    questionnaire.destroy
    head :no_content
  end

  private

  def questionnaire_params
    params.require(:questionnaire).permit(:id, :title)
  end

  def render_not_found
    render json: { error: 'Not Found' }, status: :not_found
  end

  def render_unprocessable_entity(exception)
    render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
  end
end
