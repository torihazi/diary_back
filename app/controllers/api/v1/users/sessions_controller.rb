class Api::V1::Users::SessionsController < Devise::SessionsController
  include RackSessionFix
  respond_to :json

  def new
    json_response = "失敗時のjson形式のレスポンスデータを生成"
    render :json
  end

  def create
    # self.resource = warden.authenticate!(auth_options)
    self.resource = User.find_by(email: sign_in_params[:email])
    Rails.logger.debug("resource: #{resource}")
    sign_in(resource_name, resource)
    # json_response = "json形式のレスポンスデータを生成"
    render json: {"data": resource, "message": "success sign in"}, status: :ok
  end

  protected

  # def auth_options
  #   { scope: :user, recall: "#{controller_path}#new" }
  # end

  private
  def sign_in_params
    params.require(:user).permit(:email, :password)
  end

end
