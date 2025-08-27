class SessionsController < ApplicationController
  def new
  end

  def create
    @app_session = User.create_app_session(email: login_params[:email], password: login_params[:password])

    if @app_sessions
      # TODO: Store details in cookie
      
      flash[:success] = t('.success')
      redirect_to root_path, status: :see_other
    else
    end
  end
end
