class ManDressesController < ApplicationController
	before_action :find_man_dress, only: [:show, :edit, :update, :destroy, :upvote]
	def new
		@man_dress = ManDress.new
	end
    
    def show
    	@commentable = @man_dress
    	@comments = @man_dress.comments
    	@comment = Comment.new
    end

	def index
		@man_dresses = ManDress.all
	end

	def create  
		@man_dress = ManDress.create(man_params) 
		Product.create(item_id: @man_dress.id, item_type:"ManDress", user_id: current_user.id)
		if @man_dress.save    
			byebug
			redirect_to current_user
		else    
			render :new
		end
	end 

	def upvote
    	type = params[:type]
    	if type == "upvote"          
      		l = current_user.likes.new(like_id: @man_dress.id, like_type: @man_dress.product.item_type)
      		l.save!
      	elsif type == "downvote"
      		current_user.likes.delete(@man_dress)
      	else
      		# Type missing, nothing happens
      		redirect_to :back, notice: 'Nothing happened.'
    	end
  	end

	private
		def find_man_dress
			@man_dress = ManDress.find(params[:id])			
		end

		def man_params
			 params.require(:man_dress).permit(:name, :man_category_id, :price, :description, :on_sale, :garant, images_attributes: [:id, :avatar, :_destroy],  clother_size_elements_attributes: [:clother_id, :clother_type, :clother_size_id])
		end
end
