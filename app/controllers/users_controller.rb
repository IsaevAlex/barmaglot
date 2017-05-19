class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :finish_signup, :following, :followers, :feed, :user_products, :man_dress, :woman_dress, :p]

  # GET /users/:id.:format
  def show
    @posts = @user.posts.where(["name LIKE ?","%#{params[:search]}%"]).order("created_at DESC")
    @users = User.all
    @recomended_followers = @users.sample(5)
    @feed_items = current_user.feed.where(["name LIKE ?","%#{params[:search]}%"]).order("created_at DESC")
    @feed_products = current_user.product_feed.order("created_at DESC")
    @follwedusers = @user.followed_users
    @combined = (@feed_items + @feed_products).sort_by(&:created_at).reverse
  end

  def cap(item_type)
      case item_type
      when "ManDress"
        "Мужская одежда"
      when "WomanDress"
        "Женская одежда"  
      else
        "Нет категории" 
      end
  end

  # GET /users/:id/edit
  def edit
    # authorize! :update, @user
  end
  
  def user_products
    @items = @user.products.order("created_at DESC") 
  end

  def man_dress
    @items = @user.products.man_dress.order("created_at DESC") 
    render 'user_products'
  end

  def woman_dress
    @items = @user.products.woman_dress.order("created_at DESC") 
    render 'user_products'
  end


  def following
    @title = "Подписки"
    @count = @user.followed_users.count
    @users = @user.followed_users.order("created_at DESC")
    render 'show_follow'
  end

  def followers
    @title = "Подписчики"
    @count = @user.followers.count
    @users = @user.followers.order("created_at DESC")
    render 'show_follow'
  end
  # PATCH/PUT /users/:id.:format
  def update
    # authorize! :update, @user
    respond_to do |format|
      if @user.update(user_params)
        sign_in(@user == current_user ? @user : current_user, :bypass => true)
        format.html { redirect_to @user, notice: 'Your profile was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET/PATCH /users/:id/finish_signup
  

  def current_user_home
  	 redirect_to current_user
  end    
  # DELETE /users/:id.:format
  def destroy
    # authorize! :delete, @user
    @user.destroy
    respond_to do |format|
      format.html { redirect_to root_url }
      format.json { head :no_content }
    end
  end
  
  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      accessible = [ :name, :email ] # extend with your own params
      accessible << [ :password, :password_confirmation ] unless params[:user][:password].blank?
      params.require(:user).permit(accessible).except(:search)
    end
end
