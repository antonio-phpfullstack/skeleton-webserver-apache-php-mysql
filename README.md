# Esqueleto Gratuito Apache/PHP/MySQL/PHPMyAdmin

## Ao final do projeto você terá um ambiente:
- PHP 8.3, versão mais estável
- Apache, versão mais estável
- MySQL 8.1, versão mais estável
- PHPMyAdmin, versão mais estável
- Node.js, versão 20 mais estável
- Redis, versão mais estável

**Links Úteis:**

- :tada: [Site: https://phpfullstack.com.br](https://phpfullstack.com.br/)


## Passo a passo para rodar o projeto
**Clone o projeto**
```sh
git clone https://github.com/antonio-phpfullstack/esqueleto-webserver-apache-php-mysql esqueleto-webserver-apache-php-mysql
```
```sh
cd esqueleto-webserver-apache-php-mysql/
```


**No arquivo docker/services/frontend/Dockerfile, altere o nome do usuário para o usuário da sua máquina, ex: ARG user=antonio**
```sh
ARG user=seu_usuario_linux
```


**No arquivo docker/services/backend/Dockerfile, altere o nome do usuário para o usuário da sua máquina, ex: ARG user=antonio**
```sh
ARG user=seu_usuario_linux
```


**No arquivo docker/services/backend/settings/apache/envvars, na linha 17, altere o usuário do Apache para o usuário da sua máquina, ex: : ${APACHE_RUN_USER:=antonio}**
```sh
: ${APACHE_RUN_USER:=www-data}
```


**No arquivo docker/services/backend/settings/apache/envvars, na linha 20, altere o grupo do Apache para o grupo do seu usuário da sua máquina, ex: : ${APACHE_RUN_GROUP:=antonio}**
```sh
: ${APACHE_RUN_GROUP:=www-data}
```


**Suba os contêiners do projeto**
```sh
docker-compose up -d
```

OU

```sh
docker compose up -d
```


## Acesse o projeto php back-end
- :rocket: [http://localhost:8000](http://localhost:8000)

## Acesse o projeto front-end
- :rocket: [http://localhost:8001](http://localhost:8001)


## Acesse a plataforma do PhpMyAdmin
- :brain: ***Host***: [http://localhost:8002](http://localhost:8002)
- :man: ***Usuário***: noreply@phpfullstack.com.br
- :key: ***Senha***: admin


## Observações importantes
- Depois que os contêiners estiverem em execução você terá um ambiente front-end e um ambiente back-end
- O nome do serviço do ambiente back-end, no arquivo docker-compose.yml, é backend
- O nome do serviço do ambiente front-end, no arquivo docker-compose.yml, é frontend
- Depois que o contêiners estiverem em execução, acesse o ambiente back-end com o seguinte comando:
```sh
docker-compose exec backend bash
```
OU
```sh
docker compose exec backend bash
```
- Depois que o contêiners estiverem em execução acesse o ambiente front-end com o seguinte comando:
```sh
docker-compose exec frontend bash
```
OU
```sh
docker compose exec front bash
```
- Caso você tenha seguido corretamente essa documentação, você acessará o ambiente back-end com o mesmo nome de usuário da sua máquina
- Caso você tenha seguido corretamente essa documentação, você terá criado um usuário para o ambiente front-end com o mesmo nome de usuário da sua máquina
- Mesmo que você tenha seguido corretamente essa documentação, ao acessar o ambiente front-end você estará com o usuário root
- Depois de acessar o ambiente front-end, com o comando acima citado, troque o usuário do contêiner para o usuário da sua máquina antes de executar qualquer comando
```sh
su - seu_usuario_linux
```
- Você acessará internamente o contêiner no ambiente back-end para executar o comando composer do php, por exemplo
- Você acessará internamente o contêiner no ambiente front-end para executar o comando npm, por exemplo
- Em ambos os casos serão criados arquivos e/ou diretórios, por isso da importância do nome do usuário do contêiner ser o mesmo da sua máquina
- Para voltar ao usuário root, no ambiente front-end, ou sair do terminal do contêiner, tanto no ambiente front-end quanto no ambiente back-end execute o comando abaixo:
```sh
exit
```
- Dentro do contêiner back-end, os comandos serão executados por padrão, no diretório /var/www/
- Dentro do contêiner back-end, o diretório padrão do apache esta configurado para o diretório /var/www/public/
- Dentro do contêiner back-end, essa diferenciação do diretório de execução dos comandos para o diretório padrão do apache foi realizada devido à diferentes plataformas requisitarem diferentes diretórios padrão web
- Plataformas usam caminhos de diretórios diferentes de execução para o WebServers(ex.: Laravel que usa o public)
- Dentro do contêiner back-end a configuração do diretório padrão do Apache pode ser alterada no arquivo Dockerfile. Esse arquivo esta localizado no diretório: /docker/services/backend/Dockerfile localizando a linha que contém o comando abaixo
```sh
ENV APACHE_DOCUMENT_ROOT=/var/www/public
```
- Configure o nome de usuário e o grupo do apache para o mesmo da sua máquina local. Tanto no ambiente front-end, quanto no ambiente back-end
- Com essas configurações você não terá problemas de permissão dos arquivos e diretórios
- Essas configurações são feitas no arquivo Dockerfile, nos ambientes back-end e front-end, e no arquivo envvars, no ambiente back-end
- Foi explicado com detalhes como isso deve ser feito
- Antes de realizar qualquer modificação referente a configuração leia atentamente os comentários da configuração nas linhas que antecedem essa configuração
