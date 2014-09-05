module ApplicationHelper
  def options_from_array(array, selected_value = nil)
    options_for_select(
      array.map { |a| [t("recipients.categories.#{a.to_s}"), a] },
      selected_value
    )
  end

  def follow_switch(letter)
    if user_signed_in? && current_user.followed?(letter)
      link_path = unfollow_letter_path(letter)
      fa_name = "star"
    else
      link_path = follow_letter_path(letter)
      fa_name = "empty-star"
    end
    # view_context.link_to (tag span, class: "fa fa-#{fa_name}"), link_path, class: "btn btn-default"
    link_to fa_name, link_path, class: "btn btn-default", method: :put
  end
end
