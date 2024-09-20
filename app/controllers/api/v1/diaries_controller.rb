class Api::V1::DiariesController < ApplicationController
  before_action :authenticate_api_v1_user!
  before_action :set_diary, only: [:show]
  def index
    @diaries = current_api_v1_user.diaries.all
    render json: @diaries, status: :ok
  end

  def show
    render json: @diary, status: :ok
  end

  def create
    diary = current_api_v1_user.diaries.build(diary_params)

    if diary.save
      render json: diary, status: :ok
    else
      error_messages = diary.errors.full_messages.join(',')
      render json: {message: error_messages}, status: :unprocessable_entity
    end
  end

  private
  def set_diary
    @diary = Diary.find(params[:id])
  end

  def diary_params
    params.require(:diary).permit(:title, :content)
  end
end
