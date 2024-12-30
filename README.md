# Esqueleto Gratuito Apache/PHP/MySQL/PHPMyAdmin

## Ao final do projeto você terá um ambiente:
- PHP 8.3, versão mais estável
- Apache, versão mais estável
- MySQL 8.1, versão mais estável
- PHPMyAdmin, versão mais estável
- Node.js, versão 20 mais estável
- Redis, versão 8.0-M02

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
utilizado, ex: `USUARIO=antonio...`**

```sh
USUARIO=seu_usuario_linux
GRUPO=seu_grupo_linux
UID=1000
GID=1000
```

**Suba os contêineres do projeto**
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
- Depois que os contêineres estiverem em execução você terá um ambiente front-end e um ambiente back-end
- O nome do serviço do ambiente back-end, no arquivo `docker-compose.yml`, é `backend`
- O nome do serviço do ambiente front-end, no arquivo `docker-compose.yml`, é `frontend`
- Depois que os contêineres estiverem em execução, acesse o ambiente back-end com o seguinte comando:
```sh
docker-compose exec backend bash
```
OU
```sh
docker compose exec backend bash
```
- Depois que os contêineres estiverem em execução acesse o ambiente front-end com o seguinte comando:
```sh
docker-compose exec frontend bash
```
OU
```sh
docker compose exec front bash
```
- Caso você tenha seguido corretamente essa documentação, você terá um usuário e seu respectivo grupo no ambiente back-end com o mesmo nome de usuário e grupo da sua máquina
- Caso você tenha seguido corretamente essa documentação, você terá um usuário e seu respectivo grupo no ambiente front-end com o mesmo nome de usuário e grupo da sua máquina
- Mesmo que você tenha seguido corretamente essa documentação, ao acessar o ambiente front-end você entrará logado com o usuário `root`
- Caso queira executar algum comando que envolva alteração de arquivos ou diretórios no contêiner relativo ao serviço `frontend`, após acessar o ambiente front-end, troque o usuário `root` para o usuário da sua máquina antes de executar qualquer comando
```sh
su - seu_usuario_linux
```
- Você acessará internamente o contêiner do ambiente back-end para executar o comando `composer` do php, por exemplo
- Você acessará internamente o contêiner do ambiente front-end para executar o comando `npm`, por exemplo
- Em ambos os casos serão criados arquivos e/ou diretórios, por isso da importância do nome do usuário do contêiner ser o mesmo da sua máquina
- Para voltar ao usuário `root`, no ambiente front-end, ou sair do terminal do contêiner, tanto no ambiente front-end quanto no ambiente back-end execute o comando abaixo:
```sh
exit
```
- Dentro do contêiner back-end, os comandos serão executados por padrão, no diretório `/var/www/`
- Dentro do contêiner back-end, o diretório padrão do apache está configurado para o diretório `/var/www/public/`
- Dentro do contêiner back-end, essa diferenciação do diretório de execução dos comandos para o diretório padrão do apache foi realizada devido à diferentes plataformas requisitarem diferentes diretórios padrão web
- Plataformas usam caminhos de diretórios diferentes de execução para o WebServer(ex.: Laravel que usa o `public`)
- Dentro do contêiner back-end a configuração do diretório padrão do Apache pode ser alterada no arquivo `Dockerfile`. Esse arquivo está localizado no diretório: `/docker/services/backend/Dockerfile`. Encontre a linha que contém o comando abaixo
```sh
ENV APACHE_DOCUMENT_ROOT=/var/www/public
```
## Recomendações sobre Xdebug
A configuração recomendada para o Xdebug encontra-se no arquivo `/docker/service/backend/settings/php/custom.ini`
```sh
xdebug.mode=debug
xdebug.discover_client_host=false
xdebug.client_host=172.20.0.1
xdebug.client_port=9003
```
Vamos entender o código acima. Foi colocado o Xdebug no modo `debug`. Após essa configuração devemos informar ao Xdebug,
através da diretiva `xdebug.discover_client_host`, para não tentar descobrir a máquina client. Mas o porquê disso? O 
Xdebug tentará estabelecer uma conexão local(no localhost) na porta `9003`, e apenas desabilitaremos essa tentativa de 
conexão nesse endereço/porta. Vamos raciocinar um pouco. Com quem o Xdebug vai se conectar? Com a IDE de trabalho. Onde 
a IDE está? Na máquina host local, que N-Â-O é acessada pelo endereço localhost de dentro do contêiner. Então, estando 
no contêiner, qual o endereço do host local? O endereço é a interface de rede virtual criado pelo
Docker, que é utilizada basicamente na comunicação entre os contêineres e entre um contêiner e a máquina host. Para uma
boa configuração você deverá alterar o IP contido no arquivo `/docker/service/backend/settings/php/custom.ini`
(`172.20.0.1`). Certamente no seu ambiente será outro valor. Qual? Continue lendo esse mini-tutorial.

Precisamos ter cuidado caso o host seja um Windows ou Mac. Podemos configurar `xdebug.client_host` com o 
seguinte valor:
```sh
xdebug.client_host=host.docker.internal
```
No entanto, `host.docker.internal` não funciona no sistema operacional Linux em versões desatualizadas do kernel, ou com o Docker
desatualizado. Ainda assim, mesmo que o Kernel do Linux e o Docker estejam atualizados, possa ser que não funcione.

Para contornar essa limitação do Linux, você pode encontrar na internet alguns tutoriais com procedência duvidosa. Esses 
tutoriais pedem para realizar uma alteração específica no `docker-compose.yml` com o seguinte código:
```sh
extra_hosts:
- "host.docker.internal:host-gateway"
```
Após a alteração no arquivo `docker-compose.yml`, o tutorial vai solicitar que você altere o arquivo php.ini, representado
nesse projeto pelo arquivo `/docker/service/backend/settings/php/custom.ini`:
```sh
xdebug.client_host=host.docker.internal
```
E dessa forma você teria uma única configuração para Windows/Linux/Mac. Só que isso não me agradou 100%. Sinceramente é 
uma gambiarra. Vamos entender... 

O `docker0` é a interface de rede interna virtual padrão do Docker. Ela que resolve num
contêiner quando você acessa outro contêiner pelo seu nome de serviço definido no `docker-compose.yml`. Como assim? Em um 
cenário como o nosso, foi definido dois serviços no `docker-compose.yml`: `frontend` e `backend`. Vamos dizer que não 
tivéssemos criado nenhuma rede interna, no caso criamos(criamos a rede `apache-php`, mas vamos dizer que não a tivéssemos 
criado). Caso estejamos dentro do contêiner relativo ao serviço `frontend`, e queiramos ver a resposta do servidor contido 
no serviço `backend` poderíamos digitar o seguinte comando dentro do contêiner relativo ao serviço `frontend`:
```sh
curl backend
```
Então o servidor contido no contêiner associado ao serviço `backend` entregará uma resposta. Quem foi o responsável
por efetivar a comunicação de rede entre os contêineres? A interface de rede interna. Caso não tivéssemos criado nenhuma 
rede, no arquivo `docker-compose.yml`, o responsável por essa comunicação seria o docker0. Geralmente o `docker0` tem o
endereço `172.17.0.1`

Quando configuramos um novo network no Docker, que não é o padrão `bridge`, geralmente não é utilizada a interface 
`docker0`. Então é criada uma nova interface de rede interna para esse novo network. No nosso projeto, no arquivo 
`docker-compose.yml` criamos um novo network chamado `apache-php`. Logo será usada uma nova interface de rede interna para 
comunicação entre os contêineres e entre um contêiner e o host local. Como temos agora uma nova interface de rede virtual, 
então será associado um novo IP a essa interface de rede.

Para saber qual IP o Docker associou para a nova interface de rede virtual, use o comando abaixo:
```sh
docker container inspect nome-do-contêiner
```
E procure por `Gateway`. Esse é o IP que você deve utilizar no arquivo `/docker/service/backend/settings/php/custom.ini`. Mas por que o código que foi mostrado
anteriormente no `docker-compose.yml`, e vemos em diversos tutoriais, é uma gambiarra? Vamos analisar o código novamente:
```sh
extra_hosts:
- "host.docker.internal:host-gateway"
```
Esse código define um IP ao endereço `host.docker.internal`. O valor `host-gateway` é atribuído ao `host.docker.internal` informando o IP do `docker0`. O IP que é 
associado ao `host.docker.internal` é o mesmo IP do `docker0`.
Mas perceba que não utilizamos como rede padrão a `bridge`. Utilizamos uma nova que foi definido no arquivo
`docker-compose.yml`. Logo devemos utilizar o IP da interface de rede virtual do network criado pelo `docker-compose.yml`.
No caso criamos a rede `apache-php`."Não vejo com bons olhos" utilizar o IP do `docker0`.

Então basta você inspecionar o contêiner `backend`.
```sh
docker container inspect nome-do-contêiner
```
e procurar por `Gateway`:
```sh
"Gateway": "172.20.0.1"
```
Nesse caso o IP da interface virtual é `172.20.0.1`. Mas pode variar. É esse IP que você deve colocar no custom.ini
```sh
xdebug.client_host=127.20.0.1
```
Depois de realizada a alteração no `/docker/service/backend/settings/php/custom.ini` você deverá reconstruir a imagem do serviço `backend` através do comando abaixo:
```sh
docker compose build --no-cache backend
```
E depois digitar o comando abaixo para substituir o novo contêiner
```sh
docker compose up --force-recreate -d backend
```
Ao invés de procurar manualmente, e passar por todo o processo de criação de um novo contêiner, esse processo pode ser 
feito com um script. Mas foge do escopo da finalidade desse repositório. Caso opte por utilizar a interface da rede 
`docker0` até pode funcionar, mas não estará completamente correto. Não foi encontrado nenhuma diretiva Docker que traga
o IP da interface de rede utilizada pelo contêiner.
