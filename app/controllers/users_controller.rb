class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    authorize @user
  end

  def ask_medical
    @user = User.find(params[:id])
    authorize @user
  end

  def set_medical
    @user = User.find(params[:id])
    @user.medical_info_id = MedicalInfo.where(title: params[:user][:medical_info_id]).first.id
    @user.languages = params[:user][:languages] unless params[:user][:languages] == ""
    @user.height = params[:user][:height] unless params[:user][:height] == ""
    @user.medication = params[:user][:medication] unless params[:user][:medication] == ""
    authorize @user

    if @user.save
      flash[:success] = 'User information updated successfully.'
      redirect_to profile_path(@user)
    else
      flash.now[:error] = 'Error updating user information.'
      render :ask_medical
    end
  end
end
