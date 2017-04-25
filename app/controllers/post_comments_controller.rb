class PostCommentsController < ApplicationController
	def create
		@post = Post.find(params[:post_id])
		@comment = PostComment.new
	    @comment = @post.post_comments.create(params[:post_comment].permit(:comment))
		@comment.user_id = current_user.id if current_user
		@comment.save
	end

	def destroy
		@post = Post.find(params[:post_id])
		@comment = @post.post_comments.find(params[:id])
		@comment.destroy
		respond_to do |format|
      		  format.js { flash.now[:success] = "Вы удалили отзыв" }
    	end
	end
end
