# Consulta_usuarios

## Instalação

1. Execute `bundle install` para instalar as gems do projeto
2. Crie uma role no banco de dados com o nome de `consulta_usuarios`
3. Crie as variaveis de ambiente `CONSULTA_USUARIOS_HOST`, `CONSULTA_USUARIOS_USERNAME` e `CONSULTA_USUARIOS_PASSWORD` com os dados do banco
4. Gere novas credenciais com  `EDITOR=nano rails credentials:edit`
5. Execute os seguintes comandos para criar e popular o banco: `rails db:create`,`rails db:migrate`,`rails db:seed`
6. Execute `rails assets:precompile` para preparar os assets do projeto
7. Inicie o servidor da aplicação com `rvmsudo rails s -b 0.0.0.0 -p 80 -e production` ou `rails s`

## Testando a aplicação

Para testar a aplicação, execute o comando `rails test test/models/ test/system/`

## Acessando a aplicação

A aplicação pode ser acessada neste [link](http://52.73.177.118)