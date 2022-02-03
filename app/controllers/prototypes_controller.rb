class PrototypesController < ApplicationController
  before_action :authenticate_user!,only: [:edit]
  def index
    @prototypes = Prototype.all
  end

  def new
    @prototype = Prototype.new
  end
# new + save = create
  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def edit
    @prototype = Prototype.find(params[:id])
    redirect_to action: :index
  end

  def update
    prototype = Prototype.find(params[:id])
    prototype.update(prototype_params)
    if current_user.update(user_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    ptorotype = Prototype.find(params[:id])
    prototype.destroy
  end

  private
  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

end

