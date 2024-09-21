class Api::V1::DiariesController < ApplicationController
  before_action :authenticate_api_v1_user!
  before_action :set_diary, only: [:show,:update, :destroy]

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

  def update
    if !owner_verify
      render json: {"message": "所有者ではありません"}, status: :unprocessable_entity
    end    
    
    if @diary.update(diary_params)
      render json: {"message": "更新が完了しました"}, status: :ok
    else
      Rails.logger.debug(@diary.error_messages.full_messages.join(""))
      render json: {"message": "更新に失敗しました", status: :unprocessable_entity}
    end
  end

  def destroy
    if !owner_verify
      render json: {"message": "所有者ではありません"}, status: :unprocessable_entity
    end

    if @diary.destroy
      render json: {"message": "削除が成功しました"}, status: :ok
    else
      Rails.logger.debug(@diary.error_messages.full_messages.join(","))
      render json: {"message": "削除に失敗しました"}, status: :ok
    end
  end

  private
  def set_diary
    @diary = Diary.find(params[:id])
  end

  def diary_params
    params.require(:diary).permit(:title, :content)
  end

  def owner_verify
    if @diary.user.id === current_api_v1_user.id
      return true
    else
      return false
    end
  end
end
