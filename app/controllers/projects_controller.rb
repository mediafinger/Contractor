class ProjectsController < ApplicationController
  expose(:projects)
  expose(:project)
  expose(:customers)

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

end