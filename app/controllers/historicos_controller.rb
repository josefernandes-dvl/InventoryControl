class HistoricosController < ApplicationController
  def index
    @pagy, @historicos = pagy(Historico.includes(:product).order(created_at: :desc), items: 5, overflow: :last_page)
  end
end