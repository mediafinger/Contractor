class Projects::LineItemsController < ApplicationController
  respond_to :html
  before_filter :ensure_project

  expose!(:line_item, attributes: :line_item_params)
  expose!(:line_items, attributes: :line_item_params)
  expose!(:products)
  #expose!(:project)

  def create
    line_item = LineItem.new(line_item_params)
    flash[:notice] = 'LineItem was successfully created.' if line_item.save
    respond_with @project
  end

  def edit
    line_item = @project.line_items.find(params[:id])
    respond_with line_item
  end

  def update
    line_item = @project.line_items.find(params[:id])
    flash[:notice] = 'LineItem was successfully updated.' if line_item.update_attributes(line_item_params)
    respond_with @project
  end

  def destroy
    line_item = @project.line_items.find(params[:id])
    flash[:notice] = 'LineItem was successfully deleted.' if line_item.destroy
    respond_with @project
  end


  private

    def line_item_params
      params[:line_item].merge!(:project_id => params[:project_id])
      params.require(:line_item).permit(:product_id, :project_id, :units)
    end

    def ensure_project
      @project = Project.find(params[:project_id])
    end
end
