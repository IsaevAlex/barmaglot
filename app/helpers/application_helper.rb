module ApplicationHelper	

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
