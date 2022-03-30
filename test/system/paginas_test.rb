require "application_system_test_case"

class PaginasTest < ApplicationSystemTestCase
  test "View deve apresentar o mesmo número de resultados contidos na pagina atual da consulta" do
    visit busca_path(busca: 'mr', page: 1)
    resultados = all('.resultado-card')
    assert resultados.count == busca_resultados_pagina('mr',1).count
  end

  test "View deve apresentar no máximo 10 resultados na pagina atual da consulta" do
    visit busca_path(busca: 'mr', page: 1)
    resultados = all('.resultado-card')
    assert resultados.count <= 10
  end
end
