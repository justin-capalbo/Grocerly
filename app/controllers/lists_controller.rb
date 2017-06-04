class ListsController < ApplicationController
  before_action :authenticate_user!

  def index
    @lists = current_user.lists.paginate(page: params[:page], per_page: 10)
  end

  def new
    @list = List.new
  end

  def create
    @list = current_user.lists.build(list_params)

    if @list.save
      flash[:success] = "List created!"
      redirect_to root_url
    else
      render 'new'
    end
  end

  private

    def list_params
      params.require(:list).permit(:name)
    end
end
