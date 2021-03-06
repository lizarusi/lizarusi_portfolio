module Admin
  class ProjectsController < Admin::DashboardController

    def index
      @projects = Project.all
    end

    def new
      @project = Project.new
    end

    def destroy
      @project = Project.find(params[:id])
      if @project
        @project.destroy
      end
      redirect_to admin_projects_path
    end

    def create
      @project = Project.new(project_params)
      if @project.save
        # flash[:success] = "Welcome to the Sample App!"
        p '--------------------------------------------------'
        p params[:project]
        p '--------------------------------------------------'
        NoActiveRecordUploader.new(@project.title, params[:project][:file]).save
        redirect_to [:admin, @project]

      else
        render 'new'
      end
    end

    def edit
      @project = Project.find(params[:id])
    end

    def show
      @project = Project.find(params[:id])
    end

    private

    def project_params
      params.require(:project).permit(:title, html_pages_attributes: [:html])
    end
  end
end