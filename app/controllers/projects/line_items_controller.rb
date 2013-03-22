class Projects::LineItemsController < ApplicationController
  respond_to :html

  before_filter :get_products, :only => [:new, :create, :edit, :update]
  before_filter :get_project

  def show
    @line_item = LineItem.find(params[:id])
  end

  def new
    params[:selected_product_id] = params[:set_selected_to] || @products.first
    @line_item = LineItem.new(quantity: params[:quantity])
  end

  def create
    @line_item = LineItem.new(line_item_params)
    if @line_item.save
      log(@project, @line_item.id, line_item_params, :line_item_created)
      flash[:notice] = 'LineItem was successfully created.'
      respond_with @project
    else
      flash[:error] = 'LineItem could not be saved.'
      params[:selected_product_id] = params[:line_item][:product_id] || @products.first
      render action: :new
    end
  end

  def edit
    @line_item = LineItem.find(params[:id])
  end

  def update
    @line_item = @project.line_items.find(params[:id])
    if @line_item.update_attributes(line_item_params)
      log(@project, @line_item.id, line_item_params, :line_item_updated)
      flash[:notice] = 'LineItem was successfully updated.'
      respond_with @project
    else
      flash[:error] = 'LineItem could not be saved.'
      render action: :edit
    end
  end

  def destroy
    @line_item = @project.line_items.find(params[:id])
    line_item = @line_item
    if @line_item.destroy
      log(get_project, line_item.id, line_item.attributes, :line_item_deleted)
      flash[:notice] = 'LineItem was successfully deleted.'
    end
    respond_with @project
  end


  private

    def get_products
      @products ||= ProductDecorator.decorate_collection(Product.is_active.by_key)
    end

    def get_project
      @project = Project.find(params[:project_id]).decorate
    end

    def line_item_params
      params[:line_item].merge!(:project_id => params[:project_id])
      params.require(:line_item).permit(:product_id, :project_id, :modifier, :quantity)
    end

    #TODO: Modularize and work with named params
    def log(project, line_item_id, line_item_params, action)
      ProjectLog.create(project_id: project.id, line_item_id: line_item_id, params: line_item_params.to_json, action: action)
    end

end
