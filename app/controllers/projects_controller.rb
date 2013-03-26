class ProjectsController < BaseAuthenticationController
  respond_to :html

  before_filter :get_customers, :only => [:new, :create, :edit, :update]
  before_filter :get_statuses,  :only => [:new, :create, :edit, :update]

  # edit, new method inherited from BaseAuthenticationController


  def index
    @projects = ProjectDecorator.decorate_collection(Project.by_status.by_name)
    respond_with @projects
  end

  def show
    @project = Project.find(params[:id]).decorate
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      log(@project, project_params, :created)
      flash[:notice] = 'Project was successfully created.'
    end

    respond_with @project
  end

  def update
    @project = Project.find(params[:id])
    status = @project.status_id

    if @project.update_attributes(update_params)
      log(@project, project_params, :updated, status)
      flash[:notice] = 'Project was successfully updated.'
    end

    respond_with @project
  end


  private

    def get_customers
      @customers ||= Customer.is_active.by_name
    end

    def get_statuses
      @statuses ||= Status.by_order
    end

    def project_params
      params.require(:project).permit(:customer_id, :name, :status_id)
    end

    def update_params
      params.require(:project).permit(:name, :status_id)
    end

    #TODO: how to use this RESTful??
    def payment_status_params
      params.require(:project).permit(:paid)
    end

    #TODO: Modularize and work with named params
    def log(project, project_params, action, status = nil)
      status_change = 0
      if status
        old_status = Status.find(status)
        new_status = Status.find(project.status_id)

        status_change = new_status.sorting - old_status.sorting
      end

      ProjectLog.create(project_id: project.id, params: project_params.to_json, action: action, status_change: status_change)
    end
end
