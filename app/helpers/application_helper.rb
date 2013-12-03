module ApplicationHelper
	def full_title(page_title)
		topic = "Adventure|Byte Games"
		if page_title.empty?
			topic
		else
			"#{topic} - #{page_title}"
		end
	end
end
