class ProjectsController < ApplicationController
  respond_to :html

  expose!(:projects, attributes: :project_params)
  expose!(:project, attributes: :project_params)
  expose!(:customers)
  expose!(:products)

  def create
    if project.save
      redirect_to(project)
    else
      render :new
    end
  end

  def update
    if project.save
      redirect_to(project)
    else
      render :edit
    end
  end


  private

    def project_params
      params.require(:project).permit(:customer_id, :name, :status, :products)
    end
end
