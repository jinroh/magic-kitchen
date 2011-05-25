class UserObserver < ActiveRecord::Observer
  def after_following(user)
    Delayed::Job.enqueue(Stats::FoF.new(user.id))
  end
end