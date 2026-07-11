module Admin
  class ProjectsController < BaseController
    before_action :set_project, only: %i[show edit update destroy]

    def index
      @projects = Project.order(Arel.sql("published_at DESC NULLS FIRST, created_at DESC"))
    end

    def show
    end

    def new
      @project = Project.new
    end

    def create
      @project = Project.new(project_params)
      if @project.save
        redirect_to admin_project_path(@project), notice: "Project created."
      else
        render :new, status: :unprocessable_content
      end
    end

    def edit
    end

    def update
      if @project.update(project_params)
        redirect_to admin_project_path(@project), notice: "Project updated."
      else
        render :edit, status: :unprocessable_content
      end
    end

    def destroy
      @project.destroy
      redirect_to admin_projects_path, notice: "Project deleted."
    end

    private

    def set_project
      @project = Project.find(params[:id])
    end

    def project_params
      params.expect(project: %i[title slug summary body_markdown url published_at])
    end
  end
end
