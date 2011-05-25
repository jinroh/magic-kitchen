class LikeObserver < ActiveRecord::Observer
  def after_save(like)
    Delayed::Job.enqueue(Stats::UUI.new(like.user_id, like.recipe_id))
  end
end