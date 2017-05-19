module ApplicationHelper
	def resource_name
    	:user
  	end

  	def resource
    	@resource ||= User.new
  	end

  	def devise_mapping
    	@devise_mapping ||= Devise.mappings[:user]
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

  	
end
