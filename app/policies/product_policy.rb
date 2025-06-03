class ProdutoPolicy < ApplicationPolicy
  def index?
    true # Todos os usuários podem ver
  end

  def show?
    true
  end

  def create?
    user.administrador? || user.estoquista?
  end

  def update?
    user.administrador? || user.estoquista?
  end

  def destroy?
    user.administrador?
  end
end

  class Scope < ApplicationPolicy::Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
