class Api::V1::DiariesController < ApplicationController
  before_action :authenticate_api_v1_user!

  def index
    @diaries = current_api_v1_user.diaries.all
    render json: @diaries, status: :ok
  end

end
