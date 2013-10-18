module ApplicationHelper
	#Hanya menggunakan base title jika tidak ada page title
	def full_title(page_title)
		base_title = "XTC"
		if page_title.empty?
			base_title
		else
			"#{base_title} - #{page_title}"
			end
	end
end
