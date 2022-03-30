class Usuario < ApplicationRecord
	has_many :imagens
	after_destroy :deleta_imagens

	def thumb_image
		self.imagens.filter{|img| img.nome.match?(/.*_thumb_.*/) }.first
	end

	def medium_image
		self.imagens.filter{|img| img.nome.match?(/.*_thumb_.*/) }.first
	end

	def large_image
		self.imagens.filter{|img| img.nome.match?(/.*_thumb_.*/) }.first
	end

	def deleta_imagens
		self.imagens.each{|img| img.destroy }
	end

end
