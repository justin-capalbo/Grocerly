class ItemsController < ApplicationController
  before_action :authenticate_user!  
  before_action :correct_user_destroy, only: [:destroy]
  before_action :correct_user_create, only: [:create]
  
  def destroy
    @item.destroy
    flash[:success] = "#{@item.name} deleted from #{@item.list.name}"
    respond_to do |format|
      format.html { redirect_to root_url }
      format.json { head :no_content }
      format.js   { render :layout => false }
    end
  end

  def create
    @item = @list.items.build(item_params)

    if @item.save
      notes = @item.notes.empty? ? "" : "(#{@item.notes}) " 
      flash[:success] = "#{@item.name} #{notes}added to #{@list.name}"
      redirect_to root_url
    else
      render 'pages/home'
    end
  end

  private

    def item_params
      params.require(:item).permit(:name, :notes)
    end
    
    #Confirms the correct user for deletion of items
    def correct_user_destroy
      @item = Item.find_by(id: params[:id])
      @list = @item.list
      redirect_to root_url unless current_user == @list.user 
    end
    
    def correct_user_create
      @list = List.find_by(id: params[:list_id])
      redirect_to root_url unless current_user == @list.user 
    end
end
