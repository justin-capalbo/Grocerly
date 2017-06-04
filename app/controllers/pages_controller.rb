class PagesController < ApplicationController
  
  def home
    if user_signed_in?
      @list = current_user.active_list
      unless @list.nil?
        # Existing items
        @list_items = @list.items.paginate(page: params[:page], per_page: 30) unless @list.nil?
        # New item
        @item = @list.items.build
      end 
    end
  end

  def help
  end

  def about
  end

  def contact
  end 
end
