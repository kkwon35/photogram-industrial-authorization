class UsersController < ApplicationController
  before_action :set_user, only: %i[ show liked feed discover ]

  def index
    @users = @q.result
  end

  def feed
    if @user != current_user
      redirect_to root_path, alert: "You're not authorized for that"
      return
    end

    @photos = current_user.feed.latest
  end

  def discover
    if @user != current_user
      redirect_to root_path, alert: "You're not authorized for that"
      return
    end

    @photos = current_user.discover.latest
  end

  private

    def set_user
      if params[:username]
        @user = User.find_by!(username: params.fetch(:username))
      else
        @user = current_user
      end
    end
end
