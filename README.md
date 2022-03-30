# Consulta_Usuarios

## Instalação

1. Execute `bundle install` para instalar as gems do projeto
2. Crie uma role no banco de dados com o nome de `consulta_usuarios`
3. Execute os seguintes comandos para criar e popular o banco: `rails db:create`,`rails db:migrate`,`rails db:seed`
4. Inicie o servidor da aplicação com `rvmsudo rails s -b 0.0.0.0 -p 80 -e production` ou `rails s`

## Testando a aplicação

Para testar a aplicação, execute o comando `rails test test/models/ test/system/`