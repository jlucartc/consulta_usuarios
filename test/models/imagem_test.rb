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
    assert usuario.imagens.count == 0
  end
end
