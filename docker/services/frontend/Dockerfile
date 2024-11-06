FROM httpd:2.4


# Caso o nome do grupo do usuário da sua máquina local seja diferente do nome do usuário acrescente mais uma variável de ambiente
# e localize onde essa variável esta sendo usada, abaixo nesse mesmo arquivo, e faça as devidas modificações
# Altere a variável de ambiente abaixo para o nome de usuário do seu Linux, ex: user=antonio
ARG user=antonio
ARG uid=1000


# Instalação das dependências do sistema
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    libzip-dev \
    zip \
    unzip \
    vim \
    iputils-ping


# Instalação do Node.js e npm
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs


# Limpa o cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*


# Cria um novo usuário do sistema, especificando grupos e identificador (UID), e define seu diretório inicial.
RUN useradd -G www-data,root -u $uid -d /home/$user $user


# Habilita o módulo mod_rewrite para reescrita de URLs e o módulo mod_headers para permitir cabeçalhos extras configurados no .htaccess, 
# como Access-Control-Allow-Origin, que permite o compartilhamento de recursos entre origens (CORS).
RUN a2enmod rewrite headers


# Define o proprietário do diretório /var/www
RUN chown $user:$user /usr/local/apache2/htdocs


# Define o diretório de trabalho no contêiner onde todos os comandos subsequentes serão executados
WORKDIR /var/www


# Define o usuário padrão para executar os próximos comandos no contêiner
USER $user

