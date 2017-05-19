class WomanDressesController < ApplicationController
	before_action :find_woman_dress, only: [:show, :edit, :update, :destroy, :upvote]
	respond_to :html, :json
	def new
		@woman_dress = WomanDress.new
	end

	def show
		respond_to do |format|
      		format.js {}
    	end
	end

	def show
		@commentable = @woman_dress
    	@comments = @woman_dress.comments
    	@comment = Comment.new
	end

	def index
		@woman_dresses = WomanDress.all
	end

	def upvote
    	type = params[:type]
    	if type == "upvote"          
      		l = current_user.likes.new(like_id: @woman_dress.id, like_type: @woman_dress.product.item_type)
      		l.save!
      	elsif type == "downvote"
      		current_user.likes.delete(@woman_dress)
      	else
      		# Type missing, nothing happens
      		redirect_to :back, notice: 'Nothing happened.'
    	end
  	end

	def create  
		@woman_dress = WomanDress.create(woman_params) 
		Product.create(item_id: @woman_dress.id, item_type:"WomanDress", user_id: current_user.id)
		if @woman_dress.save   
			redirect_to current_user
		else    
			render :new
		end
	end 

	private
		def find_woman_dress
			@woman_dress = WomanDress.find(params[:id])			
		end
		def woman_params
			 params.require(:woman_dress).permit(:name, :price, :description, :on_sale, :garant, :woman_category_id, images_attributes: [:id, :avatar, :_destroy], clother_size_elements_attributes: [:clother_id, :clother_type, :clother_size_id])
		end
end
