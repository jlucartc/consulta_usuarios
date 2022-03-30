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

## Relatório do projeto

Sobre o modelo de dados, foram criados apenas dois models: `Usuario` e `Imagem`. Em cada model eu inseri os campos
presentes nos dados da API, sendo que ao criar uma `Imagem`, o arquivo da imagem será criado e armazanado em `public/images`, de onde a aplicação
poderá servir para as views. As duas entidades foram validadas apenas por diretivas do próprio Rails, de forma que não foram utilizadas chaves estrangeiras ou unicidade de campos diretamente no Postgres. Ao invés disso, foram utilizadas apenas [validações do Rails](https://guides.rubyonrails.org/active_record_validations.html).

Foram criadas apenas duas views pro sistema: `index.html.erb` e `buscar.html.erb`. A primeira é a view inicial do sistema, e lista todos os usuários
cadastrados sem nenhum tipo de paginação. No momento em que o usuário faz alguma busca, o sistema é redirecionado para a rota de busca e a partir daí ele passa a apresentar paginação. Caso o usuário insira uma string vazia no campo de busca(ou apague o que havia antes), a rota de busca detecta que não há o que ser pesquisado e redireciona para a pagina inicial. Não foram utilizados form helpers por uma escolha pessoal, já que acho menos complicado utilizar html puro, fazendo uso do ERB apenas para interpolação de dados, desvios condicionais e para iterar em arrays.

O controller utilizado foi o `application_controller.rb`, que é criado por padrão no projeto. Foram criados apenas dois métodos, um para renderizar a página principal e outro para fazer a busca de usuários.

Quanto às rotas, foram utilizadas três rotas: duas de busca e uma para a página inicial. A primeira rota de busca é utilizada quando o usuário precisa inserir a string de busca no input. Como o usuário vai iniciar uma pesquisa, a aplicação não tem como utilizar o ERB pra inserir o parâmetro de pesquisa diretamente no helper da rota, que nesse caso é `buscar_path`. Logo, é necessário utilizar uma rota usual, com uma query string iniciada por `?` e com parâmetros separados por `&`s. Já nos links de cada página é possível saber tanto a string de busca quanto o número da pagina, o que torna possível utilizar a rota `buscar_params_path(busca: params[:busca], page: @page)`

Para criar os testes, resolvi testar três casos de uso que achei mais relevantes para o sistema. O primeiro é garantir que o número de páginas apresentado na view é o mesmo numero de elementos presentes na página da consulta ao banco. O segundo é garantir que o número de resultados apresentado
em uma página não ultrapassa 10. Por fim, o terceiro caso verifica se ao deletar um usuário suas imagens também estão sendo excluídas. Para os dois primeiros casos, utilizei [testes de sistema](https://guides.rubyonrails.org/testing.html#system-testing) e para o ultimo fiz um [teste no model](https://guides.rubyonrails.org/testing.html#model-testing).

Como o projeto não possui tantas funcionalidades, a construção do modelo de dados, lógica e views
foi bastante rápida. O maior empecilho do projeto foi a escolha inicial de hospedagem, que foi o Heroku.
Como o Heroku possui um [sistema de arquivos efêmero](https://devcenter.heroku.com/articles/active-storage-on-heroku), e várias operações que eu desejava fazer envolviam criar arquivos no servidor (criação de pasta e arquivos de imagens), demorei um tempo considerável pra perceber
que seria inviável continuar com o Heroku, apesar da plataforma ter ótimas ferramentas de gerenciamento. Então, decidi
hospedar a aplicação em um servidor criado no [Amazon Lightsail](https://aws.amazon.com/pt/lightsail/), serviço que eu já havia utilizado antes.