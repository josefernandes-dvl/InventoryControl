class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :charge_categories, only: [:index, :edit, :update, :create, :new]
  before_action :clean_category_params, only: [:update, :create]

  def index
    @pagy, @products = pagy(Product.order(created_at: :desc), items: 5, overflow: :last_page)
  end

  def show
  end

  def new
    @product = Product.new
    @product.build_category
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      Historico.create!(
        product: @product,
        quantity_change: @product.quantity,
        action_type: "Novo Produto",
        user: ENV['USER'] || ENV['USERNAME'] || "Sistema",
        note: "Produto criado com quantidade inicial: #{@product.quantity}"
      )

      redirect_to @product, notice: "Produto criado com sucesso."
    else
      render :new
    end
  end

  def edit
    @product.build_category unless @product.category
  end

  def update
    old_quantity = @product.quantity

    if @product.update(product_params)
      quantity_diff = @product.quantity.to_i - old_quantity.to_i

      if quantity_diff != 0
        Historico.create!(
          product: @product,
          quantity_change: quantity_diff,
          action_type: "Atualização",
          user: ENV['USER'] || ENV['USERNAME'] || "Sistema",
          note: "Quantidade alterada de #{old_quantity} para #{@product.quantity}"
        )
      end

      redirect_to @product, notice: "Produto atualizado com sucesso."
    else
      render :edit
    end
  end

  def destroy
    @product.destroy
    redirect_to products_path, notice: "Produto excluído com sucesso."
  end

  def search
    if params[:q].present?
      @products = Product.search_by_title(params[:q]).limit(10)
    else
      @products = Product.none
    end

    respond_to do |format|
      format.json { render json: @products.select(:id, :title) }
    end
  end

  private

  def clean_category_params
    if params[:product][:category_id].present?
      params[:product].delete(:category_attributes)
    elsif params[:product][:category_attributes].present? && params[:product][:category_attributes][:name].blank?
      params[:product].delete(:category_attributes)
    end
  end

  def product_params
    params.require(:product).permit(
      :title,
      :price,
      :description,
      :buy,
      :quantity,
      :category_id,
      category_attributes: [:name]
    )
  end

  def set_product
    @product = Product.find(params[:id])
  end

  def charge_categories
    @categories = Category.all
  end
end
