class ProductsController < ApplicationController
  respond_to :html

  def index
    @products = Product.all
    respond_with @products
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    flash[:notice] = 'Product was successfully created.' if @product.save
    respond_with @product
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    flash[:notice] = 'Product was successfully updated.' if @product.update_attributes(product_params)
    respond_with @product
  end


  private

    def product_params
      params.require(:product).permit(:active, :key, :name, :price, :unit)
    end
end
