module DeviseHelper
  def devise_error_messages!
    
    return "" if resource.errors.empty?

    messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    sentence = I18n.t("errors.messages.not_saved",
                      :count => resource.errors.count,
                      :resource => resource_name)

    html = <<-HTML
            #{debug resource.errors}
            <div id="error_explanation">
              <h3>#{sentence}</h3>
              <ul>#{messages}</ul>
            </div>
    HTML

    html.html_safe
  end
end