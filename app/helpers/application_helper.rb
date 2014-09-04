module ApplicationHelper
  def options_from_array(array, selected_value = nil)
    options_for_select(
      array.map { |a| [t("recipients.categories.#{a.to_s}"), a] },
      selected_value
    )
  end
end
