class ResumesController < ApplicationController

  def index
    authenticate_user!
    @resume = Resume.where(user_id: current_user.id).first
  end

  def create
    authenticate_user!
    @client = LinkedIn::Client.new
    @client.authorize_from_access(current_user.consumer_token, current_user.consumer_secret)
    @resume = Resume.create do |u|
      u.location = current_user.location
      u.picture_url = current_user.image_url
      u.summary = @client.profile(:fields => %w(summary))
      u.work_experience = @client.profile(:fields => %w(positions))
      u.education = @client.profile(:fields => %w(educations))
      u.user = current_user
    end
    
    if @resume.save
      flash[:notice] = "Resume Saved!"
      redirect_to resumes_path
    else
      flash[:success] = "Resume did not save."
      redirect_to resumes_path
    end
  end

  def show
    @resume = Resume.where(user_id: current_user.id).first
  end

  private

  def resume_params
    params.require(:resume).permit(:location, :current_status, :picture_url, :summary, :work_experience, :education, :current_status_timestamp)
  end

end