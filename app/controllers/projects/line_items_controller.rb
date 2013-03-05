class Projects::LineItemsController < ApplicationController
  respond_to :html

  expose!(:line_item, attributes: :line_item_params)
  expose!(:line_items, attributes: :line_item_params)
  expose!(:products)
  expose!(:project)


  def create
    line_item = LineItem.new(line_item_params)
    if line_item.save
      flash[:notice] = 'LineItem was successfully created.'
      respond_with project
    else
      flash[:error] = 'LineItem could not be saved.'
      render action: :new
    end
  end

  def update
    line_item = project.line_items.find(params[:id])
    if line_item.update_attributes(line_item_params)
      flash[:notice] = 'LineItem was successfully updated.'
      respond_with project
    else
      flash[:error] = 'LineItem could not be saved.'
      render action: :edit
    end
  end

  def destroy
    line_item = project.line_items.find(params[:id])
    flash[:notice] = 'LineItem was successfully deleted.' if line_item.destroy
    respond_with project
  end


  private

    def line_item_params
      params[:line_item].merge!(:project_id => params[:project_id])
      params.require(:line_item).permit(:product_id, :project_id, :modifier, :units)
    end

end
