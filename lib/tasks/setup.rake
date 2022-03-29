require 'rake'

namespace :setup do
	desc "Cria diretório de imagens caso não exista"
	task :cria_diretorio_imagens do |task|
		Dir.mkdir('public/images') if !Dir.exists?('public/images')
	end
end