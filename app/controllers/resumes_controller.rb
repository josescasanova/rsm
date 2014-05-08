class ResumesController < ApplicationController

  def index
    authenticate_user!
  end

end
