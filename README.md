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

## Recomendações sobre Xdebug
A configuração recomendada para o Xdebug encontra-se no arquivo /docker/service/backend/settings/php/custom.ini
```sh
xdebug.mode=debug
xdebug.discover_client_host=false
xdebug.client_host=172.20.0.1
xdebug.client_port=9003
```
Precisamos ter cuidado caso o host seja um Windows ou Mac. Podemos configurar xdebug.client_host com o 
seguinte valor:
```sh
xdebug.client_host=host.docker.internal
```
No entanto, host.docker.internal não funciona com Linux em versões desatualizadas do kernel, ou com o Docker
desatualizado. Ainda assim, mesmo que o Kernel do Linux e o Docker estejam atualizados, possa ser que não funcione.

Você pode encontrar em alguns tutoriais ensinando a colocar no docker-compose.yml o seguinte código:
```sh
extra_hosts:
- "host.docker.internal:host-gateway"
```
E depois configurar o xdebug.client_host do custom.ini como é feito no Windows ou Mac:
```sh
xdebug.client_host=host.docker.internal
```
Só que isso também está errado. Sinceramente é uma gambiarra. Vamos entender... O docker0 é a interface interna de rede
virtual do Docker. Ela que resolve num container quando você acessa outro container pelo seu nome de serviço definido no 
docker-compose.yml, por exemplo. Isso somente se você estiver utilizando o network padrão Bridge(já vamos entender o 
porquê dessa restrição). Como uma interface interna de rede o docker0 tem um IP associado.


Quando é utilizado o network padrão Bridge, costuma-se utilizar a interface de rede docker0 e alocar a essainterface de 
rede o endereço 172.17.0.1. Quando configuramos um novo network no Docker, que não é o padrão Bridge, geralmente não é 
utilizada a interface docker0. E é criada um outra interface de rede interna para esse novo network. Como temos agora 
uma nova interface de rede virtual, então será associado um novo IP essa interface.

Para saber qual IP o Docker associou para a interface de rede virtual, use o camando abaixo:
```sh
docker container inspect nome-do-container
```
E procure por Gateway. Esse é o IP que você deve utilizar no arquivo custom.ini. Mas por que o código que foi mostrado
anteriormente no docker-compose.yml, e vemos em diversos tutoriais, é uma gambiarra? Vamos analisar o código novamente:
```sh
extra_hosts:
- "host.docker.internal:host-gateway"
```
Esse código define um IP ao endereço host.docker.internal. A diretiva host-gateway informa o IP do docker0. O IP que é 
associado ao host.docker.internal é o mesmo IP do docker0.
Mas perceba que não utilizamos como rede padrão a Bridge. Utilizamos uma nova que criamos e que foi definido no 
docker-compose.yml. Logo devemos utilizar o IP da interface de rede virtual do network criado pelo docker-compose.yml.
Não é certo utilizar o IP do docker0.

Então basta você inspecionar o container backend.
```sh
docker container inspect nome-do-container
```
e procurar por Gateway:
```sh
"Gateway": "172.20.0.1"
```
Nesse caso o IP da interface virtual é 172.20.0.1. É esse IP que você deve colcoar no custom.ini
```sh
xdebug.client_host=127.20.0.1
```
Ao invés de procurar manualmente, poderia ser feito um script para resolver esse problema. Mas foge do escopo da 
finalidade desse repositório.
