class Usuario < ApplicationRecord
	has_many :imagens

	def thumb_image
		self.imagens.filter{|img| img.nome.match?(/.*_thumb_.*/) }.first
	end

	def medium_image
		self.imagens.filter{|img| img.nome.match?(/.*_thumb_.*/) }.first
	end

	def large_image
		self.imagens.filter{|img| img.nome.match?(/.*_thumb_.*/) }.first
	end
end
