# Esqueleto Gratuito Apache/PHP/MySQL/PHPMyAdmin

## Ao final do projeto você terá um ambiente:
- PHP 8.3, versão mais estável
- Apache, versão mais estável
- MySQL 8.1, versão mais estável
- PHPMyAdmin, versão mais estável
- Redis, versão mais estável

**Links Úteis:**

- :tada: [Site: https://phpfullstack.com.br](https://phpfullstack.com.br/)

## Observações importantes
- Os comandos executados dentro do contêiner web serão realizados, por padrão, no diretório /var/www/
- O diretório padrão do apache esta configurado para o diretório /var/www/public/
- Essa configuração foi pensado devido a diferentes plataformas requisitarem diferentes diretórios padrão 
- Plataformas usam caminhos de diretórios diferentes de execução para o WebServers(ex.: Laravel)
- A configuração do diretório padrão do Apache pode ser feita no arquivo Dockerfile 
- Localize a linha que contém o comando abaixo no arquivo Dockerfile

```sh
ENV APACHE_DOCUMENT_ROOT=/var/www/public
```

- Configure o nome de usuário e o grupo do apache para o mesmo da sua máquina local
- Com essa configuração você não terá problemas de permissão dos arquivos e diretórios
- Essa configuração é feita no arquivo Dockerfile e no arquivo envvars
- Abaixo é explicado com detalhes como isso deve ser feito
- Ao localizar a linha referente a configuração do usuário ou do grupo leia atentamente os comentários
- Os comentários referentes a essas configurações estão nas linhas acima do comando


## Passo a passo para rodar o projeto
**Clone o projeto**
```sh
git clone https://github.com/antonio-phpfullstack/esqueleto-webserver-apache-php esqueleto-webserver-apache-php
```
```sh
cd esqueleto-webserver-apache-php/
```


**No arquivo Dockerfile, altere o nome do usuário para o usuário da sua máquina, ex: ARG user=antonio**
```sh
ARG user=seu_usuario_linux
```

**No arquivo docker/apache/envvars, na linha 17, altere o usuário do Apache para o usuário da sua máquina, ex: : ${APACHE_RUN_USER:=antonio}**
```sh
: ${APACHE_RUN_USER:=www-data}
```

**No arquivo docker/apache/envvars, na linha 20, altere o grupo do Apache para o grupo do seu usuário da sua máquina, ex: : ${APACHE_RUN_GROUP:=antonio}**
```sh
: ${APACHE_RUN_GROUP:=www-data}
```


**Suba os containers do projeto**
```sh
docker-compose up -d
```

OU

```sh
docker compose up -d
```


## Acesse o projeto
- :rocket: [http://localhost:8000](http://localhost:8000)


## Acesse o PhpMyAdmin
- :brain: *** Host ***[http://localhost:8080](http://localhost:8080)
- :man: *** Usuário ***: noreply@phpfullstack.com.br
- :key: *** Senha ***: admin
