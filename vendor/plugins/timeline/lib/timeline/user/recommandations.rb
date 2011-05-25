module Timeline
  module User
    module Recommandations
      
      RECIPES_RECOMMANDATIONS   = 20
      FOLLOWING_RECOMMANDATIONS = 10
      
      def following_recommandations_ids
        Timeline.redis.lrange(following_recommandations_key, 0, FOLLOWING_RECOMMANDATIONS).map { |rec| rec.split(":") }
      end
      
      def following_recommandations
        user_ids   = following_recommandations_ids
        return [] if user_ids.empty?
        user_score = Hash[ user_ids ]
        user_ids   = user_score.keys
        
        users = self.class.where(:id => user_ids).all
        users.each do |user|
          user.score = user_score[user.id.to_s]
        end
        
        users.sort_by { |user| user.score }
      end
      
      def recipes_recommandations_ids
        Timeline.redis.lrange(recipes_recommandations_key, 0, RECIPES_RECOMMANDATIONS).map { |rec| rec.split(":") }
      end
      
      def recipes_recommandations
        recipe_ids = recipes_recommandations_ids
        return [] if recipe_ids.empty?
        recipe_score = Hash[ recipe_ids ]
        recipe_ids   = recipe_score.keys
        
        recipes = Recipe.where(:id => recipe_ids).all
        recipes.each do |recipe|
          recipe.score = recipe_score[recipe.id.to_s]
        end
        
        recipes.sort_by { |recipe| recipe.score }
      end
      
      protected
      def following_recommandations_key
        @following_recommandations_key ||= key("following_recommandations")
      end
      
      def recipes_recommandations_key
        @following_recommandations_key ||= key("recipes_recommandations")
      end
      
    end
  end
end