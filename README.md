# Desafio - Arthur Emanuel Brandão Carvalho

** A aplicação usa as seguintes tecnologias: **

Ruby 2.4.3
Rails 5.2.3
PostgreSQL

** Instruções para rodar a aplicação do desafio **

Para rodar a aplicação após recuperá-la pelo arquivo patch, é preciso:

1 - Ir no arquivo database.yml e colocar as credenciais corretas do seu PostgreSQL.

2 - Criar o banco de dados:
* rake db:create

3 - Rodar as migrações para criar as tabelas:
* rake db:migrate

4 - Rodar o seed para popular a tabela de tipos de transações com seus valores padrão e também um usuário padrão.
* rake db:seed

** Observações: **

Os valores padrão da tabela de tipos de transações são iguais aos descritos no projeto.
Utilizei autenticação básica, com devise.
Como a vaga é para back-end, não priorizei tanto o front-end. No cadastro e no relatório, usei o básico de Bootstrap e no login, usei o padrão do devise.