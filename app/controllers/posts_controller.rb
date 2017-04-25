class PostsController < ApplicationController
	before_action :find_post, only: [:show, :like]
	respond_to :html, :json

	def show
		respond_to do |format|
      		format.js {}
    	end
	end

	def new
		@post = Post.new
		respond_to do |format|
      		format.js {}
    	end
	end

	def create
		@post = current_user.posts.build(post_params)
		if  @post.save
			flash[:success] = "Новость успешно добавлена"
			redirect_back(fallback_location: current_user)
		else
			flash[:error] = "Ошшибка :("
      		redirect_back(fallback_location: current_user)
  		end
	end

	def like
    	type = params[:type]
    	if type == "like" 
      		current_user.voices << @post
      	elsif type == "unlike"
      		current_user.post_voices.delete(@post)
      	else
      		# Type missing, nothing happens
      		redirect_to :back, notice: 'Nothing happened.'
    	end
  	end
	
	private
		
		def find_post
			@post = Post.find(params[:id])
		end

		def post_params
  			params.require(:post).permit(:user_id, :name, :description, post_images_attributes: [:id, :avatar, :_destroy])
  		end
end
