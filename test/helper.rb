module Helper

  def cria_imagens_teste
    imagens = Dir['test/fixtures/files/*']
    imagens.each do |imagem|
      arquivo_imagem = File.open("public/images/#{imagem.split('/').last}",'w')
      arquivo_imagem.write(File.read(imagem))
    end
  end

  def deleta_imagens_teste
    imagens = Dir['test/fixtures/files/*']
    imagens.each do |imagem|
      path = "public/images/#{imagem.split('/').last}"
      File.delete(path) if File.exist?(path)
    end
  end

  def busca_resultados_pagina(busca,pagina)
    busca = busca.upcase.gsub(/\s+/,'.*').gsub(/([*.?<>+{}\[\]\^\$\\])/,'|\1').gsub('|','\\')
    @usuarios = Usuario.all.filter{|usuario| I18n.transliterate(usuario.nome.upcase).match?(Regexp.new(".*#{busca}.*"))}
    @usuarios = Usuario.where(id: @usuarios.pluck(:id)).page(pagina).per(10)
  end

end