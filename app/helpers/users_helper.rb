module UsersHelper

  def event_feed(event)
    user, verb, target, target_type = event.user, event.verb, event.target, event.target_type
    html = ""
    html << link_to(user.name, user_path("#{user.id}-#{user.name.parameterize}"))
    html << " #{verb} "
    html << link_to(target.name, send("#{target_type.downcase}_path".to_sym, "#{target.id}-#{target.name.parameterize}"))
    
    html.html_safe
  end

end
