class ApplicationController < ActionController::Base
	def index
		@usuarios = Usuario.all
	end

	def buscar
		params[:busca] = params[:busca].upcase.gsub(/\s+/,'.*')
		@usuarios = Usuario.all.filter{|usuario| I18n.transliterate(usuario.nome.upcase).match?(Regexp.new(".*#{params[:busca]}.*"))}
		@usuarios = Usuario.where(id: @usuarios.pluck(:id)).page(params[:current_page]).per(10)
		@total_pages = @usuarios.total_pages
		@total_resultados = @usuarios.total_count
		@page = params[:current_page].to_i
	end
end
