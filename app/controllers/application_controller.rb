class ApplicationController < ActionController::Base
	def index
		@usuarios = Usuario.all
	end

	def buscar
		string_busca = params[:busca].upcase.gsub(/\s+/,'.*').gsub(/([*.?<>+{}\[\]\^\$\\])/,'|\1').gsub('|','\\')
		@usuarios = Usuario.all.filter{|usuario| I18n.transliterate(usuario.nome.upcase).match?(Regexp.new(".*#{string_busca}.*"))}
		@usuarios = Usuario.where(id: @usuarios.pluck(:id)).page(params[:page]).per(10)
		@total_pages = @usuarios.total_pages
		@total_resultados = @usuarios.total_count
		@page = params[:page].to_i
	end
end
