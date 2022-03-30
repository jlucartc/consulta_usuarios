class ApplicationController < ActionController::Base
	def buscar
		params[:page] ||= 1
		if params[:busca].present?
			string_busca = params[:busca].upcase.gsub(/\s+/,'.*').gsub(/([*.?<>+{}\[\]\^\$\\])/,'|\1').gsub('|','\\')
			@usuarios = Usuario.all.filter{|usuario| I18n.transliterate(usuario.nome.upcase).match?(Regexp.new(".*#{string_busca}.*"))}
			@usuarios = Usuario.where(id: @usuarios.pluck(:id)).page(params[:page]).per(10)
		else
			@usuarios = Usuario.all.page(params[:page]).per(10)
		end
		@total_pages = @usuarios.total_pages
		@total_resultados = @usuarios.total_count
		@page = params[:page].to_i
	end
end
