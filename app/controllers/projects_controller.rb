class ProjectsController < ApplicationController
  respond_to :html

  expose!(:projects, attributes: :project_params)
  expose!(:project, attributes: :project_params)
  expose!(:customers)


  def create
    project = Project.new(project_params)
    flash[:notice] = 'Project was successfully created.' if project.save
    respond_with project
  end

  def update
    project = Project.find(params[:id])
    flash[:notice] = 'Project was successfully updated.' if project.update_attributes(project_params)
    respond_with project
  end


  private

    def project_params
      params.require(:project).permit(:customer_id, :name, :status)
    end
end
