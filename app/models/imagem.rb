class Imagem < ApplicationRecord
	belongs_to :usuario
	validates :nome, uniqueness: :true
	before_create :escolhe_nome

	def escolhe_nome
		self.nome = "#{self.nome.split('.').first}_#{SecureRandom.hex(20)}_.#{self.nome.split('.').last}"
		escolhe_nome if Imagem.where(nome: self.nome).any?
	end

	def path
		tempfile = Tempfile.new(self.nome)
		tempfile.write(self.arquivo)
		tempfile.path
	end

end
