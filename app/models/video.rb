class Video < ActiveRecord::Base
	SIZES = {width: 444, height: 250}
	def embed
		"<iframe width=\"#{SIZES[:width]}\" height=\"#{SIZES[:height]}\" src=\"https://www.youtube.com/embed/#{code}\" frameborder=\"0\" allowfullscreen></iframe>"
	end
	def code
		link.split('/').last() if link
	end
end
