class ProductsController < ApplicationController
	
	def index
		@products = Product.all
	end

	def show

	end

	def user_products
    	@items = @user.products
  	end

 
end
