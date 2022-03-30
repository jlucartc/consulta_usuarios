require "test_helper"

class ImagemTest < ActiveSupport::TestCase

  setup do
    cria_imagens_teste
  end

  teardown do
    deleta_imagens_teste
  end

  test "deve destruir as imagens caso o usuário seja destruido" do
    usuario = usuarios(:one)
    assert usuario.destroy
    imagens_existentes = usuario.imagens.map{|img| File.exist?("public/images/#{img.nome}") }.uniq
    assert usuario.imagens.count == 0 and imagens_existentes.count == 1 and imagens_existentes.first == false
  end
end
