class CommentsController < ApplicationController
	before_action :find_commentable

	def new
		@comment = @commentable.comments.new
	end

	def create
		@commentable = find_commentable
     	@comment = Comment.new
	    @comment = @commentable.comments.build(comment_params)
		@comment.user_id = current_user.id if current_user
		@comment.save
	end

	def destroy
		@comment = @commentable.comments.find(params[:id])
		@comment.destroy
		respond_to do |format|
      		  format.js { flash.now[:success] = "Вы удалили отзыв" }
    	end
	end

	private 

		def comment_params
			params.require(:comment).permit(:text, :user_id, :commentable_id, :commentable_type)
		end

		def find_commentable
		  resource, id = request.path.split('/')[1,2]
		  @commentable = resource.singularize.classify.constantize.find(id)
		end
end
