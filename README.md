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


## Passo a passo para executar o projeto
**Clone o projeto**
```sh
git clone https://github.com/antonio-phpfullstack/esqueleto-webserver-apache-php-mysql esqueleto-webserver-apache-php-mysql
```
```sh
cd esqueleto-webserver-apache-php-mysql/
```


**No arquivo .env, do diretório raiz, altere o nome do usuário e grupo para os valores correspondente do host que será 
utilizado, ex: USUARIO=antonio...**

```sh
USUARIO=seu_usuario_linux
GRUPO=seu_grupo_linux
UID=1000
GID=1000
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
- Caso você tenha seguido corretamente essa documentação, você terá um usuário e seu grupo para o ambiente back-end com o mesmo nome de usuário e grupo da sua máquina
- Caso você tenha seguido corretamente essa documentação, você terá um usuário e seu grupo para o ambiente front-end com o mesmo nome de usuário e grupo da sua máquina
- Mesmo que você tenha seguido corretamente essa documentação, ao acessar o ambiente front-end você estará com o usuário root
- Caso queira executar algum comando que envolva alteração de arquivos ou diretórios no contêiner do frontend, depois de acessar o ambiente front-end, troque o usuário root para o usuário da sua máquina antes de executar qualquer comando
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
- Plataformas usam caminhos de diretórios diferentes de execução para do WebServer(ex.: Laravel que usa o public)
- Dentro do contêiner back-end a configuração do diretório padrão do Apache pode ser alterada no arquivo Dockerfile. Esse arquivo está localizado no diretório: /docker/services/backend/Dockerfile. Encontre a linha que contém o comando abaixo
```sh
ENV APACHE_DOCUMENT_ROOT=/var/www/public
```
- Para configurar corretamente o XDebug veja o arquivo docker/services/backend/Dockerfile
```sh
ENV XDEBUG_CONFIG="client_host=172.17.0.1 client_port=9003"
```
- Foi configurado o XDebug, no arquivo Dockerfile, para o ambiente Linux. Caso esteja no ambiente Windows ou Mac descomente o código abaixo e comente o código acima
```sh
#ENV XDEBUG_CONFIG="client_host=host.docker.internal client_port=9003"
```
- Perceba que trabalhamos com o XDebug na porta 9003