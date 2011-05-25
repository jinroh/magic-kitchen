class SessionsController < Devise::SessionsController
  
  def create
    Delayed::Job.enqueue(Stats::Coeff.new(current_user.id))
    Delayed::Job.enqueue(Stats::Recs.new(current_user.id))
    super
  end
  
end