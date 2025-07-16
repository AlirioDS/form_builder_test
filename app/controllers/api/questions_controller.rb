# app/controllers/api/questions_controller.rb
class Api::QuestionsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  rescue_from ActiveRecord::RecordInvalid,  with: :render_unprocessable

  before_action :set_questionnaire, only: :create
  before_action :set_question,       only: %i[show update destroy]

  def create
    q = @questionnaire.questions.create!(q_params)
    render json: q, status: :created
  end

  def show
    render json: @question, status: :ok
  end

  def update
    @question.update!(q_params)
    render json: @question, status: :ok
  end

  def destroy
    @question.destroy!
    head :no_content
  end

  private

  def set_questionnaire
    @questionnaire = Questionnaire.find(params[:questionnaire_id])
  end

  def set_question
    @question = Question.find(params[:id])
  end

  def q_params
    params.require(:question).permit(
      :id,
      :label,
      :question_type,
      :position,
      config: {},
      visibility_condition: {}
    )
  end

  def render_not_found
    render json: { error: 'Not Found' }, status: :not_found
  end

  def render_unprocessable(exception)
    render json: { errors: exception.record.errors.full_messages },
           status: :unprocessable_entity
  end
end
