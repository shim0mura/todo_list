class PositionController < ApplicationController

  before_filter :set_user

  def change
    next_array = params[:task]
    current = Position.where(:user_id => @user).first

    if current.update_attributes({position: next_array})
      result = {result: 1}
    else
      result = {result: 0, position: current.position}
    end

    render :json => result
  end

  def set_user
    @user = 1
  end

end
