class Stats
  def self.sql
    "192.168.0.5"
  end
  
  def self.redis
    "localhost"
  end
  
  class FoF < Struct.new(:user_id)
    def perform
      system "python #{Rails.root}/lib/tasks/fof.py #{Stats.redis} #{user_id}"
    end
  end
  
  class Recipes
    def recipes_recommandations(user_id)
      system "python #{Rails.root}/lib/tasks/recipes_recommandations.py #{Stats.sql} #{Stats.redis} #{user_id}"
    end
    handle_asynchronously 
    
    def update_users_ingredients(user_id, recipe_id)
      system "python #{Rails.root}/lib/tasks/update_users_ingredients.py #{Stats.sql} #{user_id} #{recipe_id}"
    end
    handle_asynchronously
    
    def update_coeff(user_id)
      system "python #{Rails.root}/lib/tasks/update_coeff.py #{Stats.sql} #{Stats.redis} #{user_id}"
    end
    handle_asynchronously
    
    
  end
end