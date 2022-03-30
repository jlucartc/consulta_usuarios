class Imagem < ApplicationRecord
	belongs_to :usuario
	validates :nome, uniqueness: :true
	before_create :escolhe_nome
	after_create :cria_arquivo
	after_destroy :deleta_arquivo

	def escolhe_nome
		self.nome = "#{self.nome.split('.').first}_#{SecureRandom.hex(20)}_.#{self.nome.split('.').last}"
		escolhe_nome if Imagem.where(nome: self.nome).any?
	end

	def cria_arquivo
		arquivo = File.open(file_path,'wb')
		arquivo.write(self.arquivo)
		arquivo.close
	end

	def path
		file_path.gsub('public','')
	end

	def deleta_arquivo
		File.delete(file_path) if File.exist?(file_path)
	end

	def file_path
		"public/images/#{self.nome}"
	end

end
