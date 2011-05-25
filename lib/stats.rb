class Stats
  def self.sql
    "192.168.0.5"
  end
  
  def self.redis
    "localhost"
  end
  
  class UUI < Struct.new(:user_id, :recipe_id)
    def perform
      system "python #{Rails.root}/lib/tasks/update_users_ingredients.py #{Stats.sql} #{user_id} #{recipe_id}"
    end
  end
  
  class FoF < Struct.new(:user_id)
    def perform
      system "python #{Rails.root}/lib/tasks/fof.py #{Stats.redis} #{user_id}"
    end
  end

  class Recs < Struct.new(:user_id)
    def perform
      system "python #{Rails.root}/lib/tasks/recipes_recommandations.py #{Stats.sql} #{Stats.redis} #{user_id}"
    end
  end
  
  class Coeff < Struct.new(:user_id)
    def perform
      system "python #{Rails.root}/lib/tasks/update_coeff.py #{Stats.sql} #{Stats.redis} #{user_id}"
    end
  end
end