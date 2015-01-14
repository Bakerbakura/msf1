module ApplicationHelper

	def bootstrap_class_for flash_type
		{success: "alert-success", info: "alert-info",	warning: "alert-warning",	danger: "alert-danger"}[flash_type] || flash_type.to_s
	end

	def flash_messages(opts={})
		flash.each do |flash_type, message|
			concat(content_tag(:div, message, class: "alert #{bootstrap_class_for(flash_type)} alert-dismissible", role: "alert") do
				concat content_tag(:button, '<span aria-hidden="true">&times;</span>'.html_safe, class: "close", data: {dismiss: "alert"}, type: "button")
				concat message
			end)
		end
		nil
	end
end