class MessagesController < ApplicationController
	before_action do
   		@conversation = Conversation.find(params[:conversation_id])
   		redirect_to current_user unless @conversation.sender_id == current_user.id || @conversation.recipient_id == current_user.id
  	end
	
	def index
 		@messages = @conversation.messages
  		@message = @conversation.messages.new
	end
	
	def new
 		@message = @conversation.messages.new
	end
	
	def create
 		@message = @conversation.messages.new(message_params)
 		if @message.save
 			ActionCable.server.broadcast 'messages',
        	message: @message.body,
       		user: @message.user.email
       		redirect_to conversation_messages_path(@conversation)
       	end
 		
	end

	private
 		def message_params
  			params.require(:message).permit(:body, :user_id)
 	end
end
