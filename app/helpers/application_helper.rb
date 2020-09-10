module ApplicationHelper
  def bootstrap_class_for(key)
    case key
    when "alert"
      "danger"
    when "notice"
      "info"
    end
  end
end
