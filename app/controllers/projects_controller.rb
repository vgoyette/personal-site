class ProjectsController < ApplicationController
  def index
    @projects = Project.published
  end

  def show
    @project = Project.published.find_by!(slug: params[:slug])
  end
end
