class Public::GroupsController < ApplicationController
    before_action :authenticate_user!
    before_action :ensure_correct_user, only: [:edit, :update]
  
    def index
      @post = Post.new
      @groups = Group.all
      @user = User.find(current_user.id)
    end
  
    def show
      @post = Post.new
      @group = Group.find(params[:id])
      @user = User.find(params[:id])
      @owner = @group.owner
    end
  
    def new
      @group = Group.new
    end
  
    def create
      @group = Group.new(group_params)
      @group.owner_id = current_user.id
      if @group.save
        redirect_to groups_path, method: :post
      else
        render 'new'
      end
    end
  
    def edit
    end
  
    def update
      if @group.update(group_params)
        redirect_to groups_path
      else
        render "edit"
      end
    end
  
    private
  
    def group_params
      params.require(:group).permit(:name, :introduction)
    end
  
    def ensure_correct_user
      @group = Group.find(params[:id])
      unless @group.owner_id == current_user.id
        redirect_to groups_path
      end
    end
end

