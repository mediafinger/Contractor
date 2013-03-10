class ProjectsController < ApplicationController
  respond_to :html

  before_filter :get_customers, :only => [:new, :create, :edit, :update]
  before_filter :get_statuses,  :only => [:new, :create, :edit, :update]

  def index
    @projects = ProjectDecorator.decorate_collection(Project.by_status.by_name)
    respond_with @projects
  end

  def show
    @project = Project.find(params[:id]).decorate
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      flash[:notice] = 'Project was successfully created.'
    end

    respond_with @project
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    if @project.update_attributes(project_params)
      flash[:notice] = 'Project was successfully updated.'
    end

    respond_with @project
  end


  private

    def get_customers
      @customers ||= Customer.all
    end

    def get_statuses
      @statuses ||= Status.by_order
    end

    def project_params
      params.require(:project).permit(:customer_id, :name, :status_id)
    end
end
