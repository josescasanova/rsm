class ResumesController < ApplicationController

  def index
    authenticate_user!
    # binding.pry
  end

  def new
    @client = LinkedIn::Client.new
    @client.authorize_from_access(current_user.consumer_token, current_user.consumer_secret)
    @resume = Resume.new do |u|
      u.location = current_user.location
      u.picture_url = current_user.image_url
      u.summary = @client.profile(:fields => %w(summary))
      u.work_experience = @client.profile(:fields => %w(positions))
      u.education = @client.profile(:fields => %w(educations))
      u.user = current_user
    end

    @resume.save!

    if @resume.save
      flash[:alert] = "Resume Saved!"
      redirect_to resumes_path
    else
      flash[:error] = "Resume did not save."
      redirect_to resumes_path
    end
  end

  def create
    @resume = Resume.create(resume_params)
    if @resume.save
      flash[:success] = "Resume Saved!"
      redirect_to resumes_path
    else
      flash[:error] = "Resume did not save."
      redirect_to resumes_path
    end
  end

  private

  def resume_params
    params.require(:resume).permit(:location, :current_status, :picture_url, :summary, :work_experience, :education, :current_status_timestamp)
  end

end